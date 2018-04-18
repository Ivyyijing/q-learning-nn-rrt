function rewardValue = PredictionReward( net, uavState, uavAction )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
stateAction = [uavState'; uavAction'];
rewardValue = net(stateAction);

end

