function uavpath = RRT_WallDis( uavposition, walls, saveTolerance, ...
    objWallDis, sceneRange, stepUnit, ax, objTarget)
%RRT1 此处显示有关此函数的摘要 以距离墙的距离来判断
%   此处显示详细说明
% 初始化节点的列表，及未扩展节点编号
hold on;
nodelist = {};
unExpandNodeIndx = [];

%% 在节点列表中加入起始节点
newNode = SetRRTNode(uavposition, 0, 0);
nodelist = [nodelist newNode];
unExpandNodeIndes = [1];
[cWallDis isCollision]= CalculateUAVShortestDis(walls, ...
    uavposition, saveTolerance);
startTarDis = CalculateObjDis(newNode.position, objTarget);
currentDis = cWallDis;
currentTarDis = startTarDis + 0.1;
while (currentDis < objWallDis || startTarDis < currentTarDis) && ...
        currentTarDis > 2
    %产生一个新的点
    [newNode fatherUnExpandIndx]= GenerateNewRRTNode(nodelist, ...
        unExpandNodeIndes,sceneRange, stepUnit);
    %判断这个点合不合法（即碰不碰壁）
    [ cWallDis, isCollision ] = ...
        CalculateUAVShortestDis( walls, newNode.position, saveTolerance);
    %如果合法，则把这个点加进去, 并重新计算距离
    if isCollision == 0
        nodelist = [nodelist newNode];
        unExpandNodeIndes = [unExpandNodeIndes, length(nodelist)];
        % 父节点孩子数加1，如果已经扩展则从扩展列表删除
        nodelist{unExpandNodeIndes(fatherUnExpandIndx)}.childNo = ...
            nodelist{unExpandNodeIndes(fatherUnExpandIndx)}.childNo + 1;
        if nodelist{unExpandNodeIndes(fatherUnExpandIndx)}.childNo ==2
            unExpandNodeIndes(fatherUnExpandIndx) = [];
        end
        % 计算当前点到目标点的距离
        currentTarDis = CalculateObjDis(newNode.position, objTarget);
        currentDis = cWallDis;
        
        %test 绘图
        rrtNode1 = newNode;
        rrtNode2 = nodelist{newNode.pointer};
        plot(ax, [rrtNode1.position(1), rrtNode2.position(1)], ... 
            [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
        
    end
end

%% 生成最后的路径
uavpath = GenerateUAVPath(nodelist);

%% 绘制整颗枚举树

% % 从后往前绘制
% for j = 2 : length(nodelist)
%     i = length(nodelist) - j + 2;
%     rrtNode1 = nodelist{i};
%     rrtNode2 = nodelist{nodelist{i}.pointer};
%     plot([rrtNode1.position(1), rrtNode2.position(1)], ...
%         [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
% end
% 
%% 绘制最终路径
for i = 1 : size(uavpath, 1) - 1
    plot(ax,[uavpath(i, 1), uavpath(i + 1, 1)], ...
        [uavpath(i, 2), uavpath(i + 1, 2)], 'b-');
end

hold off;
end

