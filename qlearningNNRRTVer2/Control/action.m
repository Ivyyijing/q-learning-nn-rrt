%ִ�ж���
function [POSIuav,ROTAuav]=action(delta,cState)
% k_x=0.05;k_y=0.1;k_rota=5;
k_x=1;k_y=1;k_rota=5;
POSIuav(1,1)=cState.position(1,1)+k_x*delta(1,1);
POSIuav(2,1)=cState.position(2,1)+k_y*delta(2,1);
POSIuav(3,1)=cState.position(3,1);
% �����û�õ�����ʱ����ע�͵���~
% ROTAuav=cState.rotation+k_rota*delta_rota;
ROTAuav= 0;