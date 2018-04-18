function newNet = UpdateNetwork(net, netTrainInputs, netTrainLabels)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
% stateAction = {[uavState'; uavAction']};
% [uavState'; uavAction']
% T = {rewardValue};
% newNet = train(net,stateAction,rewardValue);
newNet = train(net,netTrainInputs,netTrainLabels);
% P = {[1; 2];[2;1];[2;3];[3;1]}
% T = {4 5 7 7};

end

