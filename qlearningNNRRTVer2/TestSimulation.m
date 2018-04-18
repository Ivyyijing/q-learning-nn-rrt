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
resolution = 30; %����״̬�ֱ���
stateNo  = resolution * resolution;
scenerange = [100, 100];

%% ���˻���״̬
%���cState�ṹ
cState.position = zeros(3, 1);
cState.rotation = 0;
%����λ�õĳ�ʼֵ
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
wallDistances = zeros(1, size(walls, 1));
for i = 1 : size(wallDistances, 2)
    wallDistances(i) = CalculateUAVDis(walls(i,:), cState.position);
end
cWallDis = min(wallDistances);


%% �����ʼֵ�Ա㱻ײ������
origPoint = cState;
origWallDis = cWallDis;
origObjDis = cObjDis;

%% Qѧϰ��ز���
%���Ҫ�������磬�����Ӧ�������������
%��ʼ�����������
actionNo = 9;
qStrategy = randi(actionNo, stateNo, 1);
%��һ���ĸ��ʲ��ô����
e = 0.1; 
%��ʼ����������
rewardMatrix = zeros(stateNo, actionNo);

%% ��ʼQѧϰ����
pState = origPoint;
pWallDis = origWallDis;
pObjDis = origObjDis;
while(cObjDis > 5)
    %�ж��Ƿ�����,������������
    if(cWallDis < 1)
        cState = origPoint;
        cWallDis = origWallDis;
        cObjDis = origObjDis;
        continue;
    end
    
    pState = cState;
    pWallDis = cWallDis;
    pObjDis = cObjDis;
    %��ȡpState�ı��
    pStateIndx = CalculateRegionIndx(pState.position,scenerange, resolution);    
    iExplore = rand();
    pActionIndx = 1;
    %ѡ����ʵĶ���
    if(iExplore < e)
        pActionIndx = randi(9);
    else
        pActionIndx = ActionSelection( pStateIndx, qStrategy );
    end
    %����delta
    delta = GetAction(pActionIndx);
    %�������˻�״̬
    [cState.position cState.rotation] = action(delta, pState);
    %����cState��Indx
    cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
    %��������߽簴���ڴ���
    if cStateIndx > size(qStrategy, 1) || cState.position(1) <= 1 || cState.position(2) <= 1
        cWallDis = 0;
        continue;
    end
    %����cState��actionIndx
    cActionIndx = ActionSelection( cStateIndx, qStrategy);
    
    %������־���    
    %����Ŀ������
    cObjDis = CalculateObjDis(cState.position, targetPoint);
    for i = 1 : size(wallDistances, 2)
        wallDistances(i) = CalculateUAVDis(walls(i,:), cState.position);
    end
    cWallDis = min(wallDistances);
    
    %��ü�ʱ�ر�ֵ
    reward = GetInstantReward(cWallDis,pWallDis, cObjDis, pObjDis);
    %���»ر�����
    rewardMatrix = UpdateRewardMatrix(rewardMatrix, pStateIndx,pActionIndx, cStateIndx, ...
        cActionIndx, reward);
    %���²���
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
    
     %��ȡpState�ı��
    pStateIndx = CalculateRegionIndx(pState.position,scenerange, resolution);    
    iExplore = rand();
    pActionIndx = 1;
    %ѡ����ʵĶ���
    %���������������һ��Ļ�������ʱ�����������
    %pActionIndx = ActionSelection( pStateIndx, qStrategy );
    %������������ᱨ�������ܵ�����ȥ��������������Ч��
    if(iExplore < e)
        pActionIndx = randi(9);
    else
        pActionIndx = ActionSelection( pStateIndx, qStrategy );
    end

    %����delta
    delta = GetAction(pActionIndx);
    %�������˻�״̬
    [cState.position cState.rotation] = action(delta, pState);
    %����cState��Indx
    cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
    %��������߽簴���ڴ���
    if cStateIndx > size(qStrategy, 1) || cState.position(1) <= 1 || cState.position(2) <= 1
        cWallDis = 0;
        continue;
    end
    %����cState��actionIndx
    cActionIndx = ActionSelection( cStateIndx, qStrategy);
    h = DrawTrack(pState, cState, ax);
    count = count + 1;
end

