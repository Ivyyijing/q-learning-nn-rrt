function newNet = InitializeNetwork( hideNo, learningRate, momentumValue)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

newNet = feedforwardnet(hideNo,'traingdx');
newNet.trainParam.showWindow = false; 
newNet.trainParam.showCommandLine = false;
newNet.trainParam.lr = learningRate; % ѧϰ��
newNet.trainParam.mc = momentumValue; % ���������ö�������Ϊc=0.9

end

