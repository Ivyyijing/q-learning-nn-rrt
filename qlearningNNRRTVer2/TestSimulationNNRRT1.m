clear all;
path(path,'.\Control');
path(path,'.\qLearning');
path(path,'.\Scene');
path(path,'.\NeuralNetwork');
path(path,'.\RRT');

%% ��ʼ������

%���ȫ����
wall1 = [30 70 30 100];
wall2 = [20 20 40 0];
wall3 = [50 30 80 20];
wall4 = [70 80 70 70];wall5 = [70 80 100 80];

wall6 = [100 0 100 100];
wall7 = [0 100 100 100];
wall8 = [0 0 0 100];
wall9 = [0 0 100 0];

wall10 = [10 50 10 40];wall11 = [10 50 20 50];wall12 = [20 50 30 40];wall13 = [30 40 10 40];
wall14 = [40 60 60 40];wall15 = [40 60 60 60];wall16 = [60 60 60 40];
wall17 = [45 85 55 85];wall18 = [55 85 55 75];wall19 = [55 75 45 75];wall20 = [45 75 45 85];
walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7;wall8; wall9; wall10;
    wall11; wall12; wall13; wall14; wall15; wall16; wall17; wall18; wall19; wall20];

%����ϰ���
% wall1 = [48 82 52 82];wall2 = [52 82 52 78];wall3 = [52 78 48 78];wall4 = [48 78 48 82];
% wall5 = [48 67 52 67];wall6 = [52 67 52 63];wall7 = [52 63 48 63];wall8 = [48 63 48 67];
% wall9 = [48 52 52 52];wall10 = [52 52 52 48];wall11 = [52 48 48 48];wall12 = [48 48 48 52];
% wall13 = [48 37 52 37];wall14 = [52 37 52 33];wall15 = [52 33 48 33];wall16 = [48 33 48 37];
% wall17 = [48 22 52 22];wall18 = [52 22 52 18];wall19 = [52 18 48 18];wall20 = [48 18 48 22];
% 
% wall21 = [28 75 32 75];wall22 = [32 75 32 71];wall23 = [32 71 28 71];wall24 = [28 71 28 75];
% wall25 = [28 60 32 60];wall26 = [32 60 32 56];wall27 = [32 56 28 56];wall28 = [28 56 28 60];
% wall29 = [28 45 32 45];wall30 = [32 45 32 41];wall31 = [32 41 28 41];wall32 = [28 41 28 45];
% wall33 = [28 30 32 30];wall34 = [32 30 32 26];wall35 = [32 26 28 26];wall36 = [28 26 28 30];
% wall37 = [28 15 32 15];wall38 = [32 15 32 11];wall39 = [32 11 28 11];wall40 = [28 11 28 15];
% 
% wall41 = [68 75 72 75];wall42 = [72 75 72 71];wall43 = [72 71 68 71];wall44 = [68 71 68 75];
% wall45 = [68 60 72 60];wall46 = [72 60 72 56];wall47 = [72 56 68 56];wall48 = [68 56 68 60];
% wall49 = [68 45 72 45];wall50 = [72 45 72 41];wall51 = [72 41 68 41];wall52 = [68 41 68 45];
% wall53 = [68 30 72 30];wall54 = [72 30 72 26];wall55 = [72 26 68 26];wall56 = [68 26 68 30];
% wall57 = [68 90 72 90];wall58 = [72 90 72 86];wall59 = [72 86 68 86];wall60 = [68 86 68 90];
% 
% wall61 = [0 100 100 100];
% wall62 = [100 0 100 100];
% wall63 = [0 0 0 100];
% wall64 = [0 0 100 0];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall8; wall9;wall10; wall11;
%           wall12; wall13; wall14; wall15; wall16; wall17;wall18; wall19; wall20; wall21; wall22; wall23; wall24;
%           wall25; wall26; wall27; wall28; wall29; wall30; wall31; wall32; wall33; wall34; wall35; wall36;wall37;
%           wall38; wall39; wall40; wall41; wall42; wall43; wall44; wall45; wall46; wall47; wall48; wall49; wall50;
%           wall51; wall52; wall53; wall54; wall55; wall56; wall57; wall58; wall59; wall60;
%           wall61; wall62; wall63; wall64];


%�Թ�
%  wall1 = [0 30 20 30];
%  wall2 = [35 40 35 70];
%  wall3 = [35 50 70 50];
%  wall4 = [50 70 50 100];
%  wall5 = [60 0 60 30];
%  wall6 = [70 70 70 80];
%  wall7 = [70 80 100 80];
%   
%  wall9 = [0 100 100 100];
%  wall10 = [100 0 100 100];
%  wall11 = [0 0 0 100];
%  wall12 = [0 0 100 0];
%  walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall9;wall10
%              ;wall11; wall12];

 %�ϰ�ǽ
%  wall1 = [20 30 50 0];
%  wall2 = [0 100 60 40];
%  wall3 = [70 80 100 50];
%  wall9 = [0 100 100 100];
%  wall10 = [100 0 100 100];
%  wall11 = [0 0 0 100];
%  wall12 = [0 0 100 0];
%  walls = [wall1; wall2; wall3; wall9;wall10
%              ;wall11; wall12];
 
         
         
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
targetPoint(3, 1) = 8
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


