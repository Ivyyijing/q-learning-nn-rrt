function actionIndes = Path2Actions( uavPath,rrtStep, actionStep )
%PATH2ACTIONS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ��������
% rrtStep RRT�ڵ��Step
% actionStep ����·��ʱ������������Step
% uavPath ���˻���һϵ�е�

pathNodeNo = size(uavPath, 1);  % ��RRT�㷨����·���Ľڵ���
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
        % ѡ����ӽ���һ����Ķ���
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

