%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              为了计算连续状态空间，把场景文成30*30份            %
%              这个函数就是为了确定是第几份                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function regionIndx = CalculateRegionIndx( position, range, resolution)
%CALCULATESTATEINDX 此处显示有关此函数的摘要
%   此处显示详细说明

i= floor(position(1) / (range(1) / resolution));
j = floor(position(2) / (range(2) / resolution));

regionIndx = (i) * resolution + j + 1;

end

