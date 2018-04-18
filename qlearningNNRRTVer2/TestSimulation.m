clear all;
path(path,'.\Control');
path(path,'.\qLearning');
path(path,'.\Scene');
path(path,'.\NeuralNetwork');

%% 初始化场景
%障碍物 
wall1 = [5 30 30 35];
wall2 = [45 15 75 40];
wall3 = [60 60 70 60];
wall4 = [5 70 85 75];
walls = [wall1; wall2; wall3; wall4];
% wall1 = [10 20 30 50];
% wall2 = [50 40 80 60];
% wall3 = [40 20 45 40];
% wall4 = [5 70 45 75];
% wall5 = [60 80 100 83];
% wall6 = [99 2 99 99];
% walls = [wall1; wall2; wall3; wall4; wall5;wall6];
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
cState.position(1, 1) = 10;
cState.position(2, 1) = 10;
cState.position(3, 1) = 8;



%控制量初始值
delta = zeros(3, 1);
%TargetPoint
targetPoint = zeros(3, 1);
targetPoint(1, 1) = 95;
targetPoint(2, 1) = 95;
targetPoint(3, 1) = 8;
plot(ax, targetPoint(1, 1), targetPoint(2, 1), 'r*', 'MarkerSize', 10);
cObjDis = CalculateObjDis(cState.position, targetPoint);
wallDistances = zeros(1, size(walls, 1));
for i = 1 : size(wallDistances, 2)
    wallDistances(i) = CalculateUAVDis(walls(i,:), cState.position);
end
cWallDis = min(wallDistances);


%% 储存出始值以便被撞后重来
origPoint = cState;
origWallDis = cWallDis;
origObjDis = cObjDis;

%% Q学习相关参数
%如果要是神经网络，这个就应该由神经网络给出
%初始策略随机产生
actionNo = 9;
qStrategy = randi(actionNo, stateNo, 1);
%有一定的概率采用纯随机
e = 0.1; 
%初始化奖励矩阵
rewardMatrix = zeros(stateNo, actionNo);

%% 开始Q学习过程
pState = origPoint;
pWallDis = origWallDis;
pObjDis = origObjDis;
while(cObjDis > 5)
    %判断是否碰壁,若碰壁则重来
    if(cWallDis < 1)
        cState = origPoint;
        cWallDis = origWallDis;
        cObjDis = origObjDis;
        continue;
    end
    
    pState = cState;
    pWallDis = cWallDis;
    pObjDis = cObjDis;
    %获取pState的编号
    pStateIndx = CalculateRegionIndx(pState.position,scenerange, resolution);    
    iExplore = rand();
    pActionIndx = 1;
    %选择合适的动作
    if(iExplore < e)
        pActionIndx = randi(9);
    else
        pActionIndx = ActionSelection( pStateIndx, qStrategy );
    end
    %计算delta
    delta = GetAction(pActionIndx);
    %更新无人机状态
    [cState.position cState.rotation] = action(delta, pState);
    %计算cState的Indx
    cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
    %如果超出边界按碰壁处理
    if cStateIndx > size(qStrategy, 1) || cState.position(1) <= 1 || cState.position(2) <= 1
        cWallDis = 0;
        continue;
    end
    %计算cState的actionIndx
    cActionIndx = ActionSelection( cStateIndx, qStrategy);
    
    %计算各种距离    
    %距离目标点距离
    cObjDis = CalculateObjDis(cState.position, targetPoint);
    for i = 1 : size(wallDistances, 2)
        wallDistances(i) = CalculateUAVDis(walls(i,:), cState.position);
    end
    cWallDis = min(wallDistances);
    
    %获得即时回报值
    reward = GetInstantReward(cWallDis,pWallDis, cObjDis, pObjDis);
    %更新回报矩阵
    rewardMatrix = UpdateRewardMatrix(rewardMatrix, pStateIndx,pActionIndx, cStateIndx, ...
        cActionIndx, reward);
    %更新策略
    qStrategy = UpdateStrategy(rewardMatrix, pStateIndx, qStrategy);   
    h = DrawTrack(pState, cState, ax);
end

figure;
h = DrawWalls(walls);
ax = gca;
cState = origPoint;
cWallDis = origWallDis;
cObjDis = origObjDis;
count = 0;
while(cObjDis > 5 && count < 1000)
    pState = cState;
    pWallDis = cWallDis;
    pObjDis = cObjDis;
    
     %获取pState的编号
    pStateIndx = CalculateRegionIndx(pState.position,scenerange, resolution);    
    iExplore = rand();
    pActionIndx = 1;
    %选择合适的动作
    %如果仅仅用下面这一句的话，会有时出不来结果的
    %pActionIndx = ActionSelection( pStateIndx, qStrategy );
    %用下面这个，会报错，比如跑到外面去，但是他可以有效果
    if(iExplore < e)
        pActionIndx = randi(9);
    else
        pActionIndx = ActionSelection( pStateIndx, qStrategy );
    end

    %计算delta
    delta = GetAction(pActionIndx);
    %更新无人机状态
    [cState.position cState.rotation] = action(delta, pState);
    %计算cState的Indx
    cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
    %如果超出边界按碰壁处理
    if cStateIndx > size(qStrategy, 1) || cState.position(1) <= 1 || cState.position(2) <= 1
        cWallDis = 0;
        continue;
    end
    %计算cState的actionIndx
    cActionIndx = ActionSelection( cStateIndx, qStrategy);
    h = DrawTrack(pState, cState, ax);
    count = count + 1;
end

