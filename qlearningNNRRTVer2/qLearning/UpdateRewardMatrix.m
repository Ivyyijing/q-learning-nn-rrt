function rewardMatrix = UpdateRewardMatrix( rewardMatrix, pStateIndx, pActionIndx, ...
    cStateIndx,cActionIndx, reward)
%GETCONSTANTREWARD �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% alpha = 0.9; %alphaֵԽ��Խ������ۼƽ���Խ��Ҫ
% gamma = 0.9; %�ۼ��ۿ۽��͵��ۿ�ֵ
alpha = 0.1; %alphaֵԽ��Խ������ۼƽ���Խ��Ҫ
gamma = 0.6; %�ۼ��ۿ۽��͵��ۿ�ֵ
rewardMatrix(pStateIndx,pActionIndx) = rewardMatrix(pStateIndx,pActionIndx) + ...
    alpha * (reward + gamma * rewardMatrix(cStateIndx, cActionIndx) - ...
    rewardMatrix(pStateIndx,pActionIndx));
% ����rewardMatrix����Q(x,a)��ֵ
end

