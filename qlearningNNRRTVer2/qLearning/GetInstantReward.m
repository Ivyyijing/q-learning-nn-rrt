%��ȡ����Reward����
function reward = GetInstantReward( dis2Wall, preDis2Wall, dis2Obj, preDis2Obj)
%GETINSTANTREWARD �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
re_FarObstacle = 0.5;
re_NearObstacle = -0.5;
re_FarObj = -0.3;
re_NearObj = 0.3;
re_Crash = -2;
reward = 0;
if dis2Wall > preDis2Wall && dis2Wall < 10
    reward = reward + re_FarObstacle; % �����Ұ����ĵ��õ�ֵ�㷨��΢����һ�£�����Ч��
end
if dis2Wall < preDis2Wall && dis2Wall < 10
    reward = reward + re_NearObstacle;
end
if dis2Obj < preDis2Obj
    reward = reward + re_NearObj;
end
if dis2Obj > preDis2Obj
    reward = reward + re_FarObj;
end
if dis2Obj < 1
    reward = reward + re_Crash;
end

end

