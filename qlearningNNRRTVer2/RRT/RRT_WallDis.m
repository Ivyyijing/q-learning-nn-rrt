function uavpath = RRT_WallDis( uavposition, walls, saveTolerance, ...
    objWallDis, sceneRange, stepUnit, ax, objTarget)
%RRT1 �˴���ʾ�йش˺�����ժҪ �Ծ���ǽ�ľ������ж�
%   �˴���ʾ��ϸ˵��
% ��ʼ���ڵ���б���δ��չ�ڵ���
hold on;
nodelist = {};
unExpandNodeIndx = [];

%% �ڽڵ��б��м�����ʼ�ڵ�
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
    %����һ���µĵ�
    [newNode fatherUnExpandIndx]= GenerateNewRRTNode(nodelist, ...
        unExpandNodeIndes,sceneRange, stepUnit);
    %�ж������ϲ��Ϸ������������ڣ�
    [ cWallDis, isCollision ] = ...
        CalculateUAVShortestDis( walls, newNode.position, saveTolerance);
    %����Ϸ�����������ӽ�ȥ, �����¼������
    if isCollision == 0
        nodelist = [nodelist newNode];
        unExpandNodeIndes = [unExpandNodeIndes, length(nodelist)];
        % ���ڵ㺢������1������Ѿ���չ�����չ�б�ɾ��
        nodelist{unExpandNodeIndes(fatherUnExpandIndx)}.childNo = ...
            nodelist{unExpandNodeIndes(fatherUnExpandIndx)}.childNo + 1;
        if nodelist{unExpandNodeIndes(fatherUnExpandIndx)}.childNo ==2
            unExpandNodeIndes(fatherUnExpandIndx) = [];
        end
        % ���㵱ǰ�㵽Ŀ���ľ���
        currentTarDis = CalculateObjDis(newNode.position, objTarget);
        currentDis = cWallDis;
        
        %test ��ͼ
        rrtNode1 = newNode;
        rrtNode2 = nodelist{newNode.pointer};
        plot(ax, [rrtNode1.position(1), rrtNode2.position(1)], ... 
            [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
        
    end
end

%% ��������·��
uavpath = GenerateUAVPath(nodelist);

%% ��������ö����

% % �Ӻ���ǰ����
% for j = 2 : length(nodelist)
%     i = length(nodelist) - j + 2;
%     rrtNode1 = nodelist{i};
%     rrtNode2 = nodelist{nodelist{i}.pointer};
%     plot([rrtNode1.position(1), rrtNode2.position(1)], ...
%         [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
% end
% 
%% ��������·��
for i = 1 : size(uavpath, 1) - 1
    plot(ax,[uavpath(i, 1), uavpath(i + 1, 1)], ...
        [uavpath(i, 2), uavpath(i + 1, 2)], 'b-');
end

hold off;
end

