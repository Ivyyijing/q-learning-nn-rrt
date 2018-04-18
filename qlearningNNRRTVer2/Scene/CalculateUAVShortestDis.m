function [ cWallDis, isCollision ] = ...
    CalculateUAVShortestDis( walls, position, tolerance)
%CALCULATEUAVSHORTESTDIS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
isCollision = 0;

%% ���û��ǽ��ֱ�ӷ���
if size(walls, 1) ==0
    cWallDis = 10000;
    return;
end

%% �ж�UAV��ǽ����С����
wallDistances = zeros(1, size(walls, 1));
for i = 1 : size(wallDistances, 2)
    wallDistances(i) = CalculateUAVDis(walls(i,:), position);
end
cWallDis = min(wallDistances);

%% ������ֵ�ж��Ƿ�����
if cWallDis < tolerance
    isCollision = 1;
end

end

