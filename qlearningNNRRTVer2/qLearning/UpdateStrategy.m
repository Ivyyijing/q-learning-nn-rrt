%由于我删了你的神经网络，所以就改用一般学习的strategy，
function Qstrategy = UpdateStrategy( rewardMatrix, pStateIndx, Qstrategy)
%UPDATESTRATEGY 此处显示有关此函数的摘要
%   此处显示详细说明
[maxreward, Qstrategy(pStateIndx)] = max(rewardMatrix(pStateIndx, :));
end

