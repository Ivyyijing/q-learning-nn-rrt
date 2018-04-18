clear all;
path(path,'.\Control');
path(path,'.\qLearning');
path(path,'.\Scene');

%% 初始化场景
%比赛墙
% wall1 = [0 0 0 50];
% wall2 = [0 50 40 50];
% wall3 = [40 50 40 100];
% wall4 = [40 100 100 100];
% wall5 = [10 0 10 40];
% wall6 = [10 40 50 40];
% wall7 = [50 40 50 90];
% wall8 = [50 90 100 90];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8];

%随机墙
% wall1 = [10 20 30 50];
% wall2 = [50 40 80 60];
% wall3 = [40 20 45 40];
% wall4 = [5 70 45 75];
% wall5 = [60 80 100 83];
% wall6 = [100 0 100 100];
% wall7 = [0 100 100 100];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7];

%随机障碍物
% wall1 = [30 20 30 30];
% wall2 = [30 30 40 30];
% wall3 = [40 30 40 20];
% wall4 = [40 20 30 20];
% 
% wall5 = [30 45 30 55];
% wall6 = [30 55 40 55];
% wall7 = [40 55 40 45];
% wall8 = [40 45 30 45];
% 
% wall9 = [30 70 30 80];
% wall10 = [30 80 40 80];
% wall11 = [40 80 40 70];
% wall12 = [40 70 30 70];
% 
% wall13 = [65 30 65 40];
% wall14 = [65 40 75 40];
% wall15 = [75 40 75 30];
% wall16 = [75 30 65 30];
% 
% wall17 = [65 55 65 65];
% wall18 = [65 65 75 65];
% wall19 = [75 65 75 55];
% wall20 = [75 55 65 55];
% wall21 = [0 100 100 100];
% wall22 = [100 0 100 100];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8; wall9;wall10; wall11;
%           wall12; wall13; wall14; wall15; wall16; wall17;wall18; wall19; wall20; wall21; wall22];


%迷宫
wall1 = [0 30 20 30];
wall2 = [35 40 35 70];
wall3 = [35 50 60 50];
wall4 = [50 70 50 100];

wall5 = [60 0 60 30];
wall6 = [70 30 70 50];
wall7 = [70 70 70 80];
wall8 = [70 80 100 80];

wall9 = [0 100 100 100];
wall10 = [100 0 100 100];

walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8; wall9;wall10];

h = DrawWalls(walls);
ax = gca;
resolution = 30; %场景状态分辨率
stateNo  = resolution * resolution;
scenerange = [100, 100];

%% 无人机的状态
%你的cState结构
cState.position = zeros(3, 1);
cState.rotation = 0;
%设置位置的初始值
% cState.position(1, 1) = 50;
% cState.position(2, 1) = 50;
% cState.position(3, 1) = 8;
cState.position(1, 1) = 5;
cState.position(2, 1) = 5;
cState.position(3, 1) = 8;

%控制量初始值
delta = zeros(3, 1);
%TargetPoint
targetPoint = zeros(3, 1);
targetPoint(1, 1) = 80;
targetPoint(2, 1) = 95;
targetPoint(3, 1) = 8;
plot(ax, targetPoint(1, 1), targetPoint(2, 1), 'r*', 'MarkerSize', 10);
cObjDis = CalculateObjDis(cState.position, targetPoint);

uavposition = [cState.position(1, 1), cState.position(2, 1)];
RRT( uavposition, walls, [targetPoint(1, 1) targetPoint(2, 1)], 4, 3, scenerange, 4);
