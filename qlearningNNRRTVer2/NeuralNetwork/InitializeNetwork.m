function newNet = InitializeNetwork( hideNo, learningRate, momentumValue)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

newNet = feedforwardnet(hideNo,'traingdx');
newNet.trainParam.showWindow = false; 
newNet.trainParam.showCommandLine = false;
newNet.trainParam.lr = learningRate; % 学习率
newNet.trainParam.mc = momentumValue; % 网络中设置动量因子为c=0.9

end

