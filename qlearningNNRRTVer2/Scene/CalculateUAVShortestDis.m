function [ cWallDis, isCollision ] = ...
    CalculateUAVShortestDis( walls, position, tolerance)
%CALCULATEUAVSHORTESTDIS 此处显示有关此函数的摘要
%   此处显示详细说明
isCollision = 0;

%% 如果没有墙则直接返回
if size(walls, 1) ==0
    cWallDis = 10000;
    return;
end

%% 判断UAV到墙的最小距离
wallDistances = zeros(1, size(walls, 1));
for i = 1 : size(wallDistances, 2)
    wallDistances(i) = CalculateUAVDis(walls(i,:), position);
end
cWallDis = min(wallDistances);

%% 根据阈值判断是否碰壁
if cWallDis < tolerance
    isCollision = 1;
end

end

