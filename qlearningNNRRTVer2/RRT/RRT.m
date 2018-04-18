function uavpath = RRT( uavposition, walls, objPosition, saveTolerance, ...
    reachThreshold, sceneRange, stepUnit)
%RRT1 此处显示有关此函数的摘要
%   此处显示详细说明
% 初始化节点的列表，及未扩展节点编号
nodelist = {};
unExpandNodeIndx = [];

%% 在节点列表中加入起始节点
newNode = SetRRTNode(uavposition, 0, 0);
nodelist = [nodelist newNode];
unExpandNodeIndes = [1];
[cWallDis isCollision]= CalculateUAVShortestDis(walls, ...
    uavposition, saveTolerance);
currentDis = CalculateObjDis(newNode.position, objPosition);
%% RRT过程
while currentDis > reachThreshold
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
        currentDis = CalculateObjDis(newNode.position, objPosition);
        
        
        %test 绘图
        rrtNode1 = newNode;
        rrtNode2 = nodelist{newNode.pointer};
        plot(gca, [rrtNode1.position(1), rrtNode2.position(1)], ... 
            [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
        hold on;
    end
end

%% 生成最后的路径
uavPath = GenerateUAVPath(nodelist);

%% 绘制整颗枚举树

% 从后往前绘制
for j = 2 : length(nodelist)
    i = length(nodelist) - j + 2;
    rrtNode1 = nodelist{i};
    rrtNode2 = nodelist{nodelist{i}.pointer};
    plot([rrtNode1.position(1), rrtNode2.position(1)], ...
        [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
end

%% 绘制最终路径
for i = 1 : size(uavPath, 1) - 1
    plot(gca,[uavPath(i, 1), uavPath(i + 1, 1)], ...
        [uavPath(i, 2), uavPath(i + 1, 2)], 'b-');
end


end

