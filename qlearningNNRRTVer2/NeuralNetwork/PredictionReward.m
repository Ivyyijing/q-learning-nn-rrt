function rewardValue = PredictionReward( net, uavState, uavAction )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
stateAction = [uavState'; uavAction'];
rewardValue = net(stateAction);

end

