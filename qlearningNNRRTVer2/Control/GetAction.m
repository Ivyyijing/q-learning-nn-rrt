function delta = GetAction( actionIndx, step )
%FORMACTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ��������ʱ��9��action ����С���̵�˳��5��ԭ�� 
% 1, ���£� 2, �£� 3, ���£� 4, �� 5, ԭ�أ� 6, �ң� 7, ���ϣ� 8, �ϣ� 9, ����
% �����Ҫ�ı���Ʒ�ʽ�Ļ���Ҫ�����������~
% step = 1; %������Ϊ1
delta = zeros(2, 1);
if actionIndx == 1
    delta(1, 1) = -(sqrt(2)/2) * step;
    delta(2, 1) = -(sqrt(2)/2) * step;
end

if actionIndx == 2
    delta(1, 1) = 0;
    delta(2, 1) = -1 * step;
end

if actionIndx == 3
    delta(1, 1) = (sqrt(2)/2) * step;
    delta(2, 1) = -(sqrt(2)/2) * step;
end

if actionIndx == 4
    delta(1, 1) = -1 * step;
    delta(2, 1) = 0;
end

if actionIndx == 5
    delta(1, 1) = 0;
    delta(2, 1) = 0;
end

if actionIndx == 6
    delta(1, 1) = 1 * step;
    delta(2, 1) = 0;
end

if actionIndx == 7
    delta(1, 1) = -(sqrt(2)/2) * step;
    delta(2, 1) = (sqrt(2)/2) * step;
end

if actionIndx == 8
    delta(1, 1) = 0;
    delta(2, 1) = 1* step;
end

if actionIndx == 9
    delta(1, 1) = 1 * step;
    delta(2, 1) = 1 * step;
end

end

