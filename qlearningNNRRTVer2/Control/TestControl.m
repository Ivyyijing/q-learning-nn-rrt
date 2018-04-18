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

%% ���˻���״̬
%���cState�ṹ
cState.position = zeros(3, 1);
cState.rotation = 0;
%����λ�õĳ�ʼֵ
cState.position(1, 1) = 50;
cState.position(2, 1) = 50;
cState.position(3, 1) = 8;

%% ��ʼ��������
%������
delta = zeros(3, 1);

%% ���ƹ���

%�ֶ��˹�����
for t = 1 : 50
    pState = cState;
    %���������ֶ����룬��ʱ����Ի������ѧϰ����
    delta(1, 1) = input('����deltaX');
    delta(2, 1) = input('����deltaY');
    delta(3, 1) = 0;
    [cState.position cState.rotation] = action(delta, cState);
    cState.position
    
    DrawTrack(pState, cState, ax);
end
