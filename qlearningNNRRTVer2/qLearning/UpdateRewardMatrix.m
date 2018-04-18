function rewardMatrix = UpdateRewardMatrix( rewardMatrix, pStateIndx, pActionIndx, ...
    cStateIndx,cActionIndx, reward)
%GETCONSTANTREWARD 此处显示有关此函数的摘要
%   此处显示详细说明
% alpha = 0.9; %alpha值越大，越靠后的累计奖赏越重要
% gamma = 0.9; %累计折扣奖赏的折扣值
alpha = 0.1; %alpha值越大，越靠后的累计奖赏越重要
gamma = 0.6; %累计折扣奖赏的折扣值
rewardMatrix(pStateIndx,pActionIndx) = rewardMatrix(pStateIndx,pActionIndx) + ...
    alpha * (reward + gamma * rewardMatrix(cStateIndx, cActionIndx) - ...
    rewardMatrix(pStateIndx,pActionIndx));
% 这里rewardMatrix就是Q(x,a)的值
end

