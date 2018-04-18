clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Scene由一系列障碍物组成，每个障碍物可以看成是一系列的约束             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% walls [x1 y1 x2 y2]
%随机全都有
% wall1 = [30 70 30 100];
% wall2 = [20 20 40 0];
% wall3 = [50 30 80 20];
% wall4 = [70 80 70 70];wall5 = [70 80 100 80];
% 
% wall6 = [100 0 100 100];
% wall7 = [0 100 100 100];
% wall8 = [0 0 0 100];
% wall9 = [0 0 100 0];
% 
% wall10 = [10 50 10 40];wall11 = [10 50 20 50];wall12 = [20 50 30 40];wall13 = [30 40 10 40];
% wall14 = [40 60 60 40];wall15 = [40 60 60 60];wall16 = [60 60 60 40];
% wall17 = [45 85 55 85];wall18 = [55 85 55 75];wall19 = [55 75 45 75];wall20 = [45 75 45 85];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7;wall8; wall9; wall10;
%     wall11; wall12; wall13; wall14; wall15; wall16; wall17; wall18; wall19; wall20];

%随机障碍物
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


%迷宫
% wall1 = [0 30 20 30];
% wall2 = [35 40 35 70];
% wall3 = [35 50 70 50];
% wall4 = [50 70 50 100];
% wall5 = [60 0 60 30];
% wall6 = [70 70 70 80];
% wall7 = [70 80 100 80];
%    
% wall9 = [0 100 100 100];
% wall10 = [100 0 100 100];
% wall11 = [0 0 0 100];
% wall12 = [0 0 100 0];
% walls = [wall1; wall2; wall3; wall4; wall5; wall6; wall7; wall9;wall10
%               ;wall11; wall12];

 %障碍墙
wall1 = [20 30 50 0];
wall2 = [0 100 60 40];
wall3 = [70 80 100 50];
wall9 = [0 100 100 100];
wall10 = [100 0 100 100];
wall11 = [0 0 0 100];
wall12 = [0 0 100 0];
walls = [wall1; wall2; wall3; wall9;wall10
            ;wall11; wall12];
 


h = DrawWalls(walls);

%% 计算无人机到墙的距离
% UAV state (X, Y) 等你想加转角在加吧:)
uavstate = [50 50];
distances = zeros(1, size(walls, 1));
for i = 1 : size(distances, 2)
    distances(i) = CalculateUAVDis(walls(i,:), uavstate);
end

