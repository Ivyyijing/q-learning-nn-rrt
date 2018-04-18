clear all;
path(path,'.\Control');
path(path,'.\qLearning');
path(path,'.\Scene');
path(path,'.\NeuralNetwork');
path(path,'.\RRT');

%% ��ʼ������
%����ǽ
wall1 = [0 0 0 50];
wall2 = [0 50 40 50];
wall3 = [40 50 40 100];
wall4 = [40 100 100 100];
wall5 = [10 0 10 40];
wall6 = [10 40 50 40];
wall7 = [50 40 50 90];
wall8 = [50 90 100 90];
walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8];

%���ǽ
% wall1 = [10 20 30 50];
% wall2 = [50 40 80 60];
% wall3 = [40 20 45 40];
% wall4 = [5 70 45 75];
% wall5 = [60 80 100 83];
% wall6 = [100 0 100 100];
% wall7 = [0 100 100 100];
% wall8 = [0 0 0 100];
% wall9 = [0 0 100 0];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7;wall8; wall9];

%����ϰ���
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
% wall23 = [0 0 0 100];
% wall24 = [0 0 100 0];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8; wall9;wall10; wall11;
%         wall12; wall13; wall14; wall15; wall16; wall17;wall18; wall19; wall20; wall21; wall22; wall23; wall24];


%�Թ�
% wall1 = [0 30 20 30];
% wall2 = [35 40 35 70];
% wall3 = [35 50 60 50];
% wall4 = [50 70 50 100];
%  
% wall5 = [60 0 60 30];
% wall6 = [70 30 70 50];
% wall7 = [70 70 70 80];
% wall8 = [70 80 100 80];
% 
% wall9 = [0 100 100 100];
% wall10 = [100 0 100 100];
% wall11 = [0 0 0 100];
% wall12 = [0 0 100 0];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8; wall9;wall10
%            ;wall11; wall12];

h = DrawWalls(walls);
collisionTolerance = 1;

ax = gca;
resolution = 9;     %����״̬�ֱ���
stateNo  = resolution * resolution;

scenerange = [100, 100];

%% ���˻���״̬
startHight = 8;
startRotation = 0;
%���cState�ṹ
cState.position = zeros(3, 1);
cState.rotation = startRotation ;
%���õĳ�ʼֵ
% cState.position(1, 1) = 50;
% cState.position(2, 1) = 50;
% cState.position(3, 1) = 8;
cState.position(1, 1) = 5;
cState.position(2, 1) = 5;
cState.position(3, 1) = startHight;



%��������ʼֵ
delta = zeros(3, 1);
%TargetPoint
targetPoint = zeros(3, 1);
targetPoint(1, 1) = 80;
targetPoint(2, 1) = 95;
targetPoint(3, 1) = 8;
plot(ax, targetPoint(1, 1), targetPoint(2, 1), 'r*', 'MarkerSize', 10);
cObjDis = CalculateObjDis(cState.position, targetPoint);
% wallDistances = zeros(1, size(walls, 1));
% for i = 1 : size(wallDistances, 2)
%     wallDistances(i) = CalculateUAVDis(walls(i,:), cState.position);
% end
% cWallDis = min(wallDistances);
cWallDis = CalculateUAVShortestDis(walls, cState.position, collisionTolerance);

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
netNo = 15
rewardNet = InitializeNetwork(netNo, 0.1, 0);
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
%     pStateIndx = CalculateRegionIndx(pState.position, scenerange, resolution);    
       
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
%     cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
%     %��������߽簴���ڴ���
%     if cState.position(1) <= 1 || cState.position(2) <= 1 || ...
%             cState.position(1) > scenerange(1) || cState.position(2) > scenerange(2)
%         cWallDis = 0;
%         continue;
%     end
  
    %������־���    
    %����Ŀ������
    cWallDis = ...
        CalculateUAVShortestDis(walls, cState.position, collisionTolerance);
    
      %����cState��actionIndx
    cActionIndx = ActionSelectionNN(qStrategy);   
    
    %��ü�ʱ�ر�ֵ    
    reward = GetInstantRewardNN(cWallDis,pWallDis, cObjDis, pObjDis);
    % ������������������
    pStateVector = [pState.position(1, 1) / scenerange(1), ...
        pState.position(2, 1) / scenerange(2)];
    newInput = [pStateVector'; actionMatrix(pActionIndx, :)'];
    netTrainInputs = [netTrainInputs, newInput];
    netTrainLabels = [netTrainLabels, reward ];
    rewardNet = InitializeNetwork(netNo, 0.1, 0);
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
  
    if cWallDis < 1.8
          %% ����RRT
         % ����ܹ��ӳ����·������
          rrtStep = 2;
          tmpActionStep = rrtStep / 3;
          tmpUavPosition = [cState.position(1, 1), cState.position(2, 1)];
         rrtPath = RRT_WallDis( tmpUavPosition, walls, 1.2, 7,...
             1.5 * scenerange, rrtStep, ax, [targetPoint(1), targetPoint(2)]);
           % ��RRTPathת�ɶ�������
           tmpActionIndes = Path2Actions( rrtPath, rrtStep, ...
              tmpActionStep  );
           % ִ����Щ��������       
           currentPoint = cState.position;        
           for tmpActionIndx = 1 : length(tmpActionIndes)
               pState = cState;
               pWallDis = cWallDis;
               pObjDis = cObjDis;
               %��ȡpState�ı��
               pStateIndx = CalculateRegionIndx(pState.position, scenerange, resolution);
               tmpActionDelta = GetAction(tmpActionIndes(tmpActionIndx), ...
                   tmpActionStep);
               %�������˻�״̬
               [cState.position cState.rotation] = action(tmpActionDelta, pState);
               cObjDis = CalculateObjDis(cState.position, targetPoint);
               %����cState��Indx
               cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution);
               %����Ŀ������
               cWallDis = ...
                   CalculateUAVShortestDis(walls, cState.position, collisionTolerance);
                           
               % ������������������
               pStateVector = [pState.position(1, 1) / scenerange(1), ...
                   pState.position(2, 1) / scenerange(2)];  
               if mod(tmpActionIndx , 8) == 0
                   %��ü�ʱ�ر�ֵ
                   newInput = [pStateVector'; actionMatrix(tmpActionIndes(tmpActionIndx), :)'];
                   %             reward = GetInstantRewardNN(cWallDis,pWallDis, cObjDis, pObjDis);
                   if cObjDis >  pObjDis
                       reward = 0.1;
                   else
                       reward = 0.1;
                   end
                   netTrainInputs = [netTrainInputs, newInput];
                   netTrainLabels = [netTrainLabels, reward ];            
                   rewardNet = InitializeNetwork(netNo, 0.1, 0);
                   %     rewardNet.trainParam.epochs = 10;
                   rewardNet = train(rewardNet,netTrainInputs,netTrainLabels);
               end
               %UpdateNetwork(rewardNet, netTrainInputs, netTrainLabels);
               h = DrawTrack(pState, cState, ax);
           end
           for j = 1 : size(actionMatrix, 1)
               qStrategy(j) = PredictionReward(rewardNet, pStateVector, ...
                   actionMatrix(j, :));    
           end  
           continue;
        %% RRT����
    elseif cWallDis < 5
        step = 1;
        tmperature = 0.3;
    elseif  cWallDis < 8
        step = 1;      
        tmperature = 0.2;
    else
        step = 2;
        tmperature = 0.1;
    end
    
    if cObjDis < 8
        step = min(step, 1);
    end
    
%     tmperature = 0.1;
    qStrategy = VectorBoltzmann(qStrategy,tmperature);
    h = DrawTrack(pState, cState, ax);
end

%%
% figure;
% h = DrawWalls(walls);
% ax = gca;
% cState = origPoint;
% cWallDis = origWallDis;
% cObjDis = origObjDis;
% 
% while(cObjDis > 5)
%     %�ж��Ƿ�����,������������
%     if(cWallDis < collisionTolerance)
%         cState = origPoint;
%         cWallDis = origWallDis;
%         cObjDis = origObjDis;
%         continue;
%     end
%     
%     pState = cState;
%     pWallDis = cWallDis;
%     pObjDis = cObjDis;
%     %��ȡpState�ı��
% %     pStateIndx = CalculateRegionIndx(pState.position, scenerange, resolution);    
%        
%     iExplore = rand();
%     pActionIndx = 1;
%     %ѡ����ʵĶ���
% %     if(iExplore < e)
% %         pActionIndx = randi(9);
% %     else
% %         pActionIndx = ActionSelectionNN(qStrategy);
% %     end
%     pActionIndx = ActionSelectionNN(qStrategy);
% 
% 
%     %����delta
%     delta = GetAction(pActionIndx, step);
%     %�������˻�״̬
%     [cState.position cState.rotation] = action(delta, pState);
%     cObjDis = CalculateObjDis(cState.position, targetPoint);
%     %����cState��Indx
% %     cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution); 
% %     %��������߽簴���ڴ���
% %     if cState.position(1) <= 1 || cState.position(2) <= 1 || ...
% %             cState.position(1) > scenerange(1) || cState.position(2) > scenerange(2)
% %         cWallDis = 0;
% %         continue;
% %     end
%   
%     %������־���    
%     %����Ŀ������
%     cWallDis = ...
%         CalculateUAVShortestDis(walls, cState.position, collisionTolerance);
%     
%       %����cState��actionIndx
%     cActionIndx = ActionSelectionNN(qStrategy);   
%     
%     %��ü�ʱ�ر�ֵ    
%     reward = GetInstantRewardNN(cWallDis,pWallDis, cObjDis, pObjDis);
%     % ������������������
%     pStateVector = [pState.position(1, 1) / scenerange(1), ...
%         pState.position(2, 1) / scenerange(2)];  
% %     newInput = [pStateVector'; actionMatrix(pActionIndx, :)'];
% %     netTrainInputs = [netTrainInputs, newInput];
% %     netTrainLabels = [netTrainLabels, reward ];
% %     rewardNet = InitializeNetwork(10, 0.1, 0);
% % %     rewardNet.trainParam.epochs = 10;
% %     rewardNet = train(rewardNet,netTrainInputs,netTrainLabels); %UpdateNetwork(rewardNet, netTrainInputs, netTrainLabels);
%     %���»ر�����,���������������Ĳ���
% %     rewardMatrix = UpdateRewardMatrix(rewardMatrix, pStateIndx,pActionIndx, cStateIndx, ...
% %         cActionIndx, reward);
%     %���²���
% %     qStrategy = UpdateStrategy(rewardMatrix, pStateIndx, qStrategy);  
% % ���Q���ԣ�����������ֵ
%   
%     for j = 1 : size(actionMatrix, 1)
%         qStrategy(j) = PredictionReward(rewardNet, pStateVector, ...
%             actionMatrix(j, :));
%     end
%   
%     if cWallDis < 1.8
%         % ����RRT
%         % ����ܹ��ӳ����·������
%         rrtStep = 2;
%         tmpActionStep = rrtStep / 3;
%         tmpUavPosition = [cState.position(1, 1), cState.position(2, 1)];
%         rrtPath = RRT_WallDis( tmpUavPosition, walls, 1.2, 7,...
%             1.5 * scenerange, rrtStep, ax, [targetPoint(1), targetPoint(2)]);
%         % ��RRTPathת�ɶ�������
%         tmpActionIndes = Path2Actions( rrtPath, rrtStep, ...
%            tmpActionStep  );
%         % ִ����Щ��������
%         
%         currentPoint = cState.position;        
%         for tmpActionIndx = 1 : length(tmpActionIndes)
%             pState = cState;
%             pWallDis = cWallDis;
%             pObjDis = cObjDis;
%             %��ȡpState�ı��
%             pStateIndx = CalculateRegionIndx(pState.position, scenerange, resolution);
%             tmpActionDelta = GetAction(tmpActionIndes(tmpActionIndx), ...
%                 tmpActionStep);
%             %�������˻�״̬
%             [cState.position cState.rotation] = action(tmpActionDelta, pState);
%             cObjDis = CalculateObjDis(cState.position, targetPoint);
%             %����cState��Indx
%             cStateIndx = CalculateRegionIndx(cState.position,scenerange, resolution);
%             %����Ŀ������
%             cWallDis = ...
%                 CalculateUAVShortestDis(walls, cState.position, collisionTolerance);
%                         
%             % ������������������
%             pStateVector = [pState.position(1, 1) / scenerange(1), ...
%                 pState.position(2, 1) / scenerange(2)];  
% %             if mod(tmpActionIndx , 5) == 0
% %                 %��ü�ʱ�ر�ֵ
% %                 newInput = [pStateVector'; actionMatrix(pActionIndx, :)'];
% %                 %             reward = GetInstantRewardNN(cWallDis,pWallDis, cObjDis, pObjDis);
% %                 reward = 0.1;
% %                 netTrainInputs = [netTrainInputs, newInput];
% %                 netTrainLabels = [netTrainLabels, reward ];            
% %                 rewardNet = InitializeNetwork(10, 0.1, 0);
% %                 %     rewardNet.trainParam.epochs = 10;
% %                 rewardNet = train(rewardNet,netTrainInputs,netTrainLabels);
% %             end
%             %UpdateNetwork(rewardNet, netTrainInputs, netTrainLabels);
%             h = DrawTrack(pState, cState, ax);
%         end
%         for j = 1 : size(actionMatrix, 1)
%             qStrategy(j) = PredictionReward(rewardNet, pStateVector, ...
%                 actionMatrix(j, :));    
%         end  
%         continue;     
%     elseif cWallDis < 5
%         step = 1;
%         tmperature = 0.3;
%     elseif  cWallDis < 8
%         step = 1;      
%         tmperature = 0.2;
%     else
%         step = 2;
%         tmperature = 0.1;
%     end
%     
% %     tmperature = 0.1;
%     qStrategy = VectorBoltzmann(qStrategy,tmperature);
%     h = DrawTrack(pState, cState, ax);
% end

%%
for i = 1 : 10000
    haha = 1;
end


