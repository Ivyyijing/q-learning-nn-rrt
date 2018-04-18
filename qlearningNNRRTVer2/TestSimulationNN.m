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
wall5 = [100 0 100 100];
walls = [wall1; wall2; wall3; wall4; wall5];
% wall1 = [10 20 30 50];
% wall2 = [50 40 80 60];
% wall3 = [40 20 45 40];
% wall4 = [5 70 45 75];
% wall5 = [60 80 100 83];
% wall6 = [99 2 99 99];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6];
h = DrawWalls(walls);
collisionTolerance = 1;

ax = gca;
resolution = 9;     %场景状态分辨率
stateNo  = resolution * resolution;

scenerange = [100, 100];

%% 无人机的状态
%你的cState结构
cState.position = zeros(3, 1);
cState.rotation = 0;
%设置的初始值
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
% wallDistances = zeros(1, size(walls, 1));
% for i = 1 : size(wallDistances, 2)
%     wallDistances(i) = CalculateUAVDis(walls(i,:), cState.position);
% end
% cWallDis = min(wallDistances);
cWallDis = CalculateUAVShortestDis(walls, cState.position, collisionTolerance)

% 储存出始值以便被撞后重来
origPoint = cState;
origWallDis = cWallDis;
origObjDis = cObjDis;

%% Q学习相关参数
%策略总数
actionNo = 9;
actionMatrix = eye(actionNo);

% 用了神经网络之后qStrategy相当于储存在了网络里所以这里就用一个行向量来存储
qStrategy = ones(1, actionNo);
temperature = 0.1; %波尔兹曼分布的温度
qStrategy = VectorBoltzmann(qStrategy, 1);
% qStrategy = randi(actionNo, stateNo, 1);
% 有一定的概率采用纯随机
e = 0.05;
% 初始化奖励矩阵，如果是神经网络，那么它就是一个神经网络
rewardNet = InitializeNetwork(10, 0.1, 0.9);
rewardNet.trainParam.epochs = 1000;

%% 开始Q学习过程
pState = origPoint;
pWallDis = origWallDis;
pObjDis = origObjDis;

% rewardMatrix = zeros(stateNo, actionNo);
netTrainInputs = [];
netTrainLabels = [];
step = 2;
while(cObjDis > 5)
    %判断是否碰壁,若碰壁则重来
    if(cWallDis < collisionTolerance)
        cState = origPoint;
        cWallDis = origWallDis;
        cObjDis = origObjDis;
        continue;
    end
    
    pState = cState;
    pWallDis = cWallDis;
    pObjDis = cObjDis;
    %获取pState的编号
    pStateIndx = CalculateRegionIndx(pState.position, scenerange, resolution);    
       
    iExplore = rand();
    pActionIndx = 1;
    %选择合适的动作
    if(iExplore < e)
        pActionIndx = randi(9);
    else
        pActionIndx = ActionSelectionNN(qStrategy);
    end


    %计算delta
    delta = GetAction(pActionIndx, step);
    %更新无人机状态
    [cState.position cState.rotation] = action(delta, pState);
    cObjDis = CalculateObjDis(cState.position, targetPoint);
    %计算cState的Indx
    cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
    %如果超出边界按碰壁处理
    if cState.position(1) <= 1 || cState.position(2) <= 1 || ...
            cState.position(1) > scenerange(1) || cState.position(2) > scenerange(2)
        cWallDis = 0;
        continue;
    end
    %计算cState的actionIndx
    cActionIndx = ActionSelectionNN(qStrategy);
    
    %计算各种距离    
    %距离目标点距离
    cWallDis = ...
        CalculateUAVShortestDis(walls, cState.position, collisionTolerance);
    
    %获得即时回报值    
    reward = GetInstantRewardNN(cWallDis,pWallDis, cObjDis, pObjDis);
    % 更新神经网络的输入输出
    pStateVector = [pState.position(1, 1) / scenerange(1), ...
        pState.position(2, 1) / scenerange(2)];  
    newInput = [pStateVector'; actionMatrix(pActionIndx, :)'];
    netTrainInputs = [netTrainInputs, newInput];
    netTrainLabels = [netTrainLabels, reward ];
    rewardNet = InitializeNetwork(10, 0.1, 0);
%     rewardNet.trainParam.epochs = 10;
    rewardNet = train(rewardNet,netTrainInputs,netTrainLabels); %UpdateNetwork(rewardNet, netTrainInputs, netTrainLabels);
    %更新回报矩阵,神经网络就用神经网络的策略
%     rewardMatrix = UpdateRewardMatrix(rewardMatrix, pStateIndx,pActionIndx, cStateIndx, ...
%         cActionIndx, reward);
    %更新策略
%     qStrategy = UpdateStrategy(rewardMatrix, pStateIndx, qStrategy);  
% 获得Q策略，用神经网络算值
  
    for j = 1 : size(actionMatrix, 1)
        qStrategy(j) = PredictionReward(rewardNet, pStateVector, ...
            actionMatrix(j, :));
    end
  
    if cWallDis < 5
        step = 0.5;
        tmperature = 0.3;
    else
        if cWallDis < 8
            step = 1;      
            tmperature = 0.2;
        else
            step = 2;
            tmperature = 0.1;
        end
    end
    
%     tmperature = 0.1;
    qStrategy = VectorBoltzmann(qStrategy,tmperature);


    h = DrawTrack(pState, cState, ax);
end

for i = 1 : 10000
    haha = 1;
end


