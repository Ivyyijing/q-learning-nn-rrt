function dis = CalculateUAVDis(wall, position)
%CalculateSensorDis 一堵墙到一个无人机的距离
% 计算一堵墙到一个无人机的距离，wall: [x1 y1 x2 y2],
% position: [x y]传感器的位置、可近似为无人机的位置

%计算无人机到墙的其中一个点的向量
vectorUAV2Point1 = [wall(1) - position(1), wall(2) - position(2)];
%计算无人机到墙的另一个点的向量
vectorUAV2Point2 = [wall(3) - position(1), wall(4) - position(2)];
%计算墙的向量
vectorWall = [wall(3) - wall(1), wall(4) - wall(2)];

%计算一个向量与墙向量的内积
dotProduct1 = vectorUAV2Point1(1) * vectorWall(1) + vectorUAV2Point1(2) * vectorWall(2);
%计算另一个向量与墙向量的内积
dotProduct2 = vectorUAV2Point2(1) * vectorWall(1) + vectorUAV2Point2(2) * vectorWall(2);

%如果两个内积一正一负，说明无人机在墙的范围内，那么距离就用点到线的距离来表示
if(dotProduct1 * dotProduct2 <=0)
    %算面积再除以底
    area = abs(vectorUAV2Point1(1) * vectorWall(2) - vectorUAV2Point1(2) * vectorWall(1));
    dis = area / sqrt(vectorWall(1)^2 + vectorWall(2)^2);    
else %如果两个内积都是正或者两个都是负的则说明无人机在墙的范围外，则到墙的距离就是距离墙的两个点中最近的那个距离
    dis1 = sqrt(vectorUAV2Point1(1)^2 + vectorUAV2Point1(2)^2);
    dis2 = sqrt(vectorUAV2Point2(1)^2 + vectorUAV2Point2(2)^2);
    dis = min(dis1, dis2);
end
end

