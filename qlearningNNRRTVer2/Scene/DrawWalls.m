function h = DrawWalls(walls)
%SET 此处显示有关此函数的摘要
%   此处显示详细说明
wallNum = size(walls, 1);
for i = 1: wallNum
    line([walls(i, 1) walls(i, 3)], [walls(i, 2) walls(i, 4)]);
    hold on
end
h = gca;
end

