%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Ϊ�˼�������״̬�ռ䣬�ѳ����ĳ�30*30��            %
%              �����������Ϊ��ȷ���ǵڼ���                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function regionIndx = CalculateRegionIndx( position, range, resolution)
%CALCULATESTATEINDX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

i= floor(position(1) / (range(1) / resolution));
j = floor(position(2) / (range(2) / resolution));

regionIndx = (i) * resolution + j + 1;

end

