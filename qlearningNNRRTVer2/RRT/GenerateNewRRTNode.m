function [newNode fatherUnExpandIndx] = GenerateNewRRTNode( nodelist, ... 
    unExpandNodeIndes, sceneRange, stepUnit)
%GENERATENEWNODE 此处显示有关此函数的摘要
%   此处显示详细说明

%% 生成区域范围内的随机点
randpoint = zeros(1, 2);
randPoint(1) = rand() * sceneRange(1);
randPoint(2) = rand() * sceneRange(2);


%% 求随机点到各个未扩展点的距离,及最小距离
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

%% 生成新点位置信息
pointsVector = [randPoint(1) - fatherNode.position(1), ...
    randPoint(2) - fatherNode.position(2)];
stepRatio = stepUnit / shortestDis;
stepVector = stepRatio * pointsVector;
newNodePosition = fatherNode.position + stepVector;

%% 生成新节点
newNode = SetRRTNode(newNodePosition, ...
    unExpandNodeIndes(fatherUnExpandIndx), 0);

end

