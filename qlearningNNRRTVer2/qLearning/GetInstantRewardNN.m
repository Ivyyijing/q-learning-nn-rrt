%获取单步Reward函数
function reward = GetInstantRewardNN( dis2Wall, preDis2Wall, ...
    dis2Obj, preDis2Obj)
%GETINSTANTREWARD 此处显示有关此函数的摘要
%   此处显示详细说明

re_FarObstacle = 0.4;
re_NearObstacle = -0.4;

% if dis2Wall < 5
%     re_FarObstacle = 1;
%     re_NearObstacle = -1;
% end

% disWallPer = abs(dis2Wall - preDis2Wall) / 2;
disWallPer = 0.75;
if dis2Wall < 2
      disWallPer = 3;
end

re_FarObj = -0.3;
re_NearObj = 0.3;
% if dis2Obj < 10
%     re_FarObj = -2;
%     re_NearObj = 2;
% end

 disObjPer = abs(dis2Obj - preDis2Obj) / 2;
 
 disObjPer = 1;
 if dis2Obj < 8
      disObjPer = 5;
 end
 
re_Crash = -2;
reward = 0;
if dis2Wall > preDis2Wall && dis2Wall < 5
    reward = reward + re_FarObstacle * disWallPer; % 这里我把论文的用的值算法稍微改了一下，看看效果
end
if dis2Wall < preDis2Wall && dis2Wall < 5
    reward = reward + re_NearObstacle * disWallPer;
end
if dis2Obj < preDis2Obj
    reward = reward + re_NearObj * disObjPer ;
end
if dis2Obj > preDis2Obj
    reward = reward + re_FarObj * disObjPer ;
end
if dis2Wall < 1
    reward = reward + re_Crash;
end

end

