%������ɾ����������磬���Ծ͸���һ��ѧϰ��strategy��
function Qstrategy = UpdateStrategy( rewardMatrix, pStateIndx, Qstrategy)
%UPDATESTRATEGY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[maxreward, Qstrategy(pStateIndx)] = max(rewardMatrix(pStateIndx, :));
end

