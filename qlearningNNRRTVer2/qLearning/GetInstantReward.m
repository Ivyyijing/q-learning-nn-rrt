%获取单步Reward函数
function reward = GetInstantReward( dis2Wall, preDis2Wall, dis2Obj, preDis2Obj)
%GETINSTANTREWARD 此处显示有关此函数的摘要
%   此处显示详细说明
re_FarObstacle = 0.5;
re_NearObstacle = -0.5;
re_FarObj = -0.3;
re_NearObj = 0.3;
re_Crash = -2;
reward = 0;
if dis2Wall > preDis2Wall && dis2Wall < 10
    reward = reward + re_FarObstacle; % 这里我把论文的用的值算法稍微改了一下，看看效果
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

