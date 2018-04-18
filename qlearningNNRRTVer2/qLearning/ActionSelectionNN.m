function actionIndx = ActionSelectionNN( qStrategy )
%QLEARNINGPROCESS 此处显示有关此函数的摘要
%   此处显示详细说明
r = rand();
qStrategyAcu = zeros(size(qStrategy));
qStrategyAcu(1) = qStrategy(1);
for i = 2: length(qStrategy)
    qStrategyAcu(i) = qStrategy(i) + qStrategyAcu(i -1);
end
actionIndx = 1;
for i = 2: length(qStrategy)
    if r >=  qStrategyAcu(i - 1) && r < qStrategyAcu(i) 
        actionIndx = i;
        break;
    end    
end
end

