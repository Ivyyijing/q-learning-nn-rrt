clear all;
path(path,'.\Control');
path(path,'.\qLearning');
path(path,'.\Scene');
path(path,'.\NeuralNetwork');

%% ��ʼ������
%�ϰ��� 
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
resolution = 9;     %����״̬�ֱ���
stateNo  = resolution * resolution;

scenerange = [100, 100];

%% ���˻���״̬
%���cState�ṹ
cState.position = zeros(3, 1);
cState.rotation = 0;
%���õĳ�ʼֵ
% cState.position(1, 1) = 50;
% cState.position(2, 1) = 50;
% cState.position(3, 1) = 8;
cState.position(1, 1) = 10;
cState.position(2, 1) = 10;
cState.position(3, 1) = 8;



%��������ʼֵ
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

% �����ʼֵ�Ա㱻ײ������
origPoint = cState;
origWallDis = cWallDis;
origObjDis = cObjDis;

%% Qѧϰ��ز���
%��������
actionNo = 9;
actionMatrix = eye(actionNo);

% ����������֮��qStrategy�൱�ڴ������������������������һ�����������洢
qStrategy = ones(1, actionNo);
temperature = 0.1; %���������ֲ����¶�
qStrategy = VectorBoltzmann(qStrategy, 1);
% qStrategy = randi(actionNo, stateNo, 1);
% ��һ���ĸ��ʲ��ô����
e = 0.05;
% ��ʼ��������������������磬��ô������һ��������
rewardNet = InitializeNetwork(10, 0.1, 0.9);
rewardNet.trainParam.epochs = 1000;

%% ��ʼQѧϰ����
pState = origPoint;
pWallDis = origWallDis;
pObjDis = origObjDis;

% rewardMatrix = zeros(stateNo, actionNo);
netTrainInputs = [];
netTrainLabels = [];
step = 2;
while(cObjDis > 5)
    %�ж��Ƿ�����,������������
    if(cWallDis < collisionTolerance)
        cState = origPoint;
        cWallDis = origWallDis;
        cObjDis = origObjDis;
        continue;
    end
    
    pState = cState;
    pWallDis = cWallDis;
    pObjDis = cObjDis;
    %��ȡpState�ı��
    pStateIndx = CalculateRegionIndx(pState.position, scenerange, resolution);    
       
    iExplore = rand();
    pActionIndx = 1;
    %ѡ����ʵĶ���
    if(iExplore < e)
        pActionIndx = randi(9);
    else
        pActionIndx = ActionSelectionNN(qStrategy);
    end


    %����delta
    delta = GetAction(pActionIndx, step);
    %�������˻�״̬
    [cState.position cState.rotation] = action(delta, pState);
    cObjDis = CalculateObjDis(cState.position, targetPoint);
    %����cState��Indx
    cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
    %��������߽簴���ڴ���
    if cState.position(1) <= 1 || cState.position(2) <= 1 || ...
            cState.position(1) > scenerange(1) || cState.position(2) > scenerange(2)
        cWallDis = 0;
        continue;
    end
    %����cState��actionIndx
    cActionIndx = ActionSelectionNN(qStrategy);
    
    %������־���    
    %����Ŀ������
    cWallDis = ...
        CalculateUAVShortestDis(walls, cState.position, collisionTolerance);
    
    %��ü�ʱ�ر�ֵ    
    reward = GetInstantRewardNN(cWallDis,pWallDis, cObjDis, pObjDis);
    % ������������������
    pStateVector = [pState.position(1, 1) / scenerange(1), ...
        pState.position(2, 1) / scenerange(2)];  
    newInput = [pStateVector'; actionMatrix(pActionIndx, :)'];
    netTrainInputs = [netTrainInputs, newInput];
    netTrainLabels = [netTrainLabels, reward ];
    rewardNet = InitializeNetwork(10, 0.1, 0);
%     rewardNet.trainParam.epochs = 10;
    rewardNet = train(rewardNet,netTrainInputs,netTrainLabels); %UpdateNetwork(rewardNet, netTrainInputs, netTrainLabels);
    %���»ر�����,���������������Ĳ���
%     rewardMatrix = UpdateRewardMatrix(rewardMatrix, pStateIndx,pActionIndx, cStateIndx, ...
%         cActionIndx, reward);
    %���²���
%     qStrategy = UpdateStrategy(rewardMatrix, pStateIndx, qStrategy);  
% ���Q���ԣ�����������ֵ
  
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


