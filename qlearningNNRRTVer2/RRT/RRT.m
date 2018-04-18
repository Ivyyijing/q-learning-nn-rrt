function uavpath = RRT( uavposition, walls, objPosition, saveTolerance, ...
    reachThreshold, sceneRange, stepUnit)
%RRT1 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ��ʼ���ڵ���б���δ��չ�ڵ���
nodelist = {};
unExpandNodeIndx = [];

%% �ڽڵ��б��м�����ʼ�ڵ�
newNode = SetRRTNode(uavposition, 0, 0);
nodelist = [nodelist newNode];
unExpandNodeIndes = [1];
[cWallDis isCollision]= CalculateUAVShortestDis(walls, ...
    uavposition, saveTolerance);
currentDis = CalculateObjDis(newNode.position, objPosition);
%% RRT����
while currentDis > reachThreshold
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
        currentDis = CalculateObjDis(newNode.position, objPosition);
        
        
        %test ��ͼ
        rrtNode1 = newNode;
        rrtNode2 = nodelist{newNode.pointer};
        plot(gca, [rrtNode1.position(1), rrtNode2.position(1)], ... 
            [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
        hold on;
    end
end

%% ��������·��
uavPath = GenerateUAVPath(nodelist);

%% ��������ö����

% �Ӻ���ǰ����
for j = 2 : length(nodelist)
    i = length(nodelist) - j + 2;
    rrtNode1 = nodelist{i};
    rrtNode2 = nodelist{nodelist{i}.pointer};
    plot([rrtNode1.position(1), rrtNode2.position(1)], ...
        [rrtNode1.position(2), rrtNode2.position(2)], 'g-');
end

%% ��������·��
for i = 1 : size(uavPath, 1) - 1
    plot(gca,[uavPath(i, 1), uavPath(i + 1, 1)], ...
        [uavPath(i, 2), uavPath(i + 1, 2)], 'b-');
end


end

