function [newNode fatherUnExpandIndx] = GenerateNewRRTNode( nodelist, ... 
    unExpandNodeIndes, sceneRange, stepUnit)
%GENERATENEWNODE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

%% ��������Χ�ڵ������
randpoint = zeros(1, 2);
randPoint(1) = rand() * sceneRange(1);
randPoint(2) = rand() * sceneRange(2);


%% ������㵽����δ��չ��ľ���,����С����
shortestDis = 100000;
shortestDisIndx = 0;
for i = 1 : length(unExpandNodeIndes)
    tmpNode = nodelist{unExpandNodeIndes(i)};
    tmpDis = CalculatePointDis(randPoint, tmpNode.position);
    if tmpDis < shortestDis
        shortestDis = tmpDis;
        shortestDisIndx = i;
    end
end
fatherUnExpandIndx = shortestDisIndx;
fatherNode = nodelist{unExpandNodeIndes(fatherUnExpandIndx)};

%% �����µ�λ����Ϣ
pointsVector = [randPoint(1) - fatherNode.position(1), ...
    randPoint(2) - fatherNode.position(2)];
stepRatio = stepUnit / shortestDis;
stepVector = stepRatio * pointsVector;
newNodePosition = fatherNode.position + stepVector;

%% �����½ڵ�
newNode = SetRRTNode(newNodePosition, ...
    unExpandNodeIndes(fatherUnExpandIndx), 0);

end

