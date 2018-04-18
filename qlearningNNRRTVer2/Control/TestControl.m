clear all
path(path,'..\Scene');
%% walls [x1 y1 x2 y2]
wall1 = [5 30 30 35];
wall2 = [45 15 75 40];
wall3 = [60 60 70 60];
wall4 = [5 70 85 75];
walls = [wall1; wall2; wall3; wall4];
h = DrawWalls(walls);
ax = gca;

%% 无人机的状态
%你的cState结构
cState.position = zeros(3, 1);
cState.rotation = 0;
%设置位置的初始值
cState.position(1, 1) = 50;
cState.position(2, 1) = 50;
cState.position(3, 1) = 8;

%% 初始化控制量
%控制量
delta = zeros(3, 1);

%% 控制过程

%手动人工控制
for t = 1 : 50
    pState = cState;
    %这里我先手动输入，到时你可以换成你的学习函数
    delta(1, 1) = input('输入deltaX');
    delta(2, 1) = input('输入deltaY');
    delta(3, 1) = 0;
    [cState.position cState.rotation] = action(delta, cState);
    cState.position
    
    DrawTrack(pState, cState, ax);
end
