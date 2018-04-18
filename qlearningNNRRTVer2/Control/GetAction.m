function delta = GetAction( actionIndx, step )
%FORMACTION 此处显示有关此函数的摘要
%   此处显示详细说明
% 这里我暂时用9个action 就是小键盘的顺序，5是原地 
% 1, 左下； 2, 下； 3, 右下； 4, 左； 5, 原地； 6, 右； 7, 左上； 8, 上； 9, 右上
% 如果你要改变控制方式的话就要改这个函数啦~
% step = 1; %步长设为1
delta = zeros(2, 1);
if actionIndx == 1
    delta(1, 1) = -(sqrt(2)/2) * step;
    delta(2, 1) = -(sqrt(2)/2) * step;
end

if actionIndx == 2
    delta(1, 1) = 0;
    delta(2, 1) = -1 * step;
end

if actionIndx == 3
    delta(1, 1) = (sqrt(2)/2) * step;
    delta(2, 1) = -(sqrt(2)/2) * step;
end

if actionIndx == 4
    delta(1, 1) = -1 * step;
    delta(2, 1) = 0;
end

if actionIndx == 5
    delta(1, 1) = 0;
    delta(2, 1) = 0;
end

if actionIndx == 6
    delta(1, 1) = 1 * step;
    delta(2, 1) = 0;
end

if actionIndx == 7
    delta(1, 1) = -(sqrt(2)/2) * step;
    delta(2, 1) = (sqrt(2)/2) * step;
end

if actionIndx == 8
    delta(1, 1) = 0;
    delta(2, 1) = 1* step;
end

if actionIndx == 9
    delta(1, 1) = 1 * step;
    delta(2, 1) = 1 * step;
end

end

