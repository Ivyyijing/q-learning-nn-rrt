function actionIndes = Path2Actions( uavPath,rrtStep, actionStep )
%PATH2ACTIONS 此处显示有关此函数的摘要
%   此处显示详细说明
% 函数功能
% rrtStep RRT节点的Step
% actionStep 生成路径时可以允许的最大Step
% uavPath 无人机的一系列点

pathNodeNo = size(uavPath, 1);  % 由RRT算法给出路径的节点数
actionIndes = [];
actionNo = 0;
startPoint = uavPath(1, :);
dis2ObjNode = rrtStep;
currentPoint = startPoint;
counter = 0;
for i = 2 : pathNodeNo    
    objNode = uavPath(i, :);
    dis2ObjNode = CalculatePointDis( currentPoint, objNode );
    while dis2ObjNode > rrtStep / 5
        counter = counter + 1;
        tmpVector = [objNode(1) - currentPoint(1) , ...
            objNode(2) - currentPoint(2)];
        % 选择最接近下一个点的动作
        if  tmpVector(1) > 0 && ...
                0.4142 * tmpVector(1) >=  abs(tmpVector(2))
            actionIndes = [actionIndes, 6];
        elseif tmpVector(1) > 0 && tmpVector(2) >= 0 && ...
                0.4142 * tmpVector(1) < tmpVector(2) && ...
                tmpVector(1) > 0.4142 * tmpVector(2)
            actionIndes = [actionIndes, 9];
        elseif tmpVector(2) > 0 && ...
                0.4142 * tmpVector(2) >=  abs(tmpVector(1))
            actionIndes = [actionIndes, 8];
        elseif tmpVector(2) > 0 && tmpVector(1) <= 0 && ...
                -0.4142 * tmpVector(1) < tmpVector(2) && ...
                -tmpVector(1) > 0.4142 * tmpVector(2)
            actionIndes = [actionIndes, 7];
        elseif  tmpVector(1) < 0 && ...
                -0.4142 * tmpVector(1) >=  abs(tmpVector(2)) 
            actionIndes = [actionIndes, 4];
        elseif tmpVector(1) < 0 && tmpVector(2) <= 0 && ...
                -0.4142 * tmpVector(1) < -tmpVector(2) && ...
                -tmpVector(1) > -0.4142 * tmpVector(2)
            actionIndes = [actionIndes, 1];
        elseif tmpVector(2) < 0 && ...
                -0.4142 * tmpVector(2) >=  abs(tmpVector(1))
            actionIndes = [actionIndes, 2];
        elseif tmpVector(1) > 0 && tmpVector(2) <= 0 && ...
                0.4142 * tmpVector(1) < -tmpVector(2) && ...
                tmpVector(1) > 0.4142 * -tmpVector(2)
            actionIndes = [actionIndes, 3];
        else
            actionIndes = [actionIndes, 1];
        end
        
        actionNo = actionNo + 1;
        actionDelta = GetAction(actionIndes(actionNo), actionStep);
        currentPoint = [currentPoint(1) + actionDelta(1), ...
            currentPoint(2) + actionDelta(2)];
        dis2ObjNode = CalculatePointDis( currentPoint, objNode );        
        if counter  > 2000
            haha = 1;
        end
    end
end

end

