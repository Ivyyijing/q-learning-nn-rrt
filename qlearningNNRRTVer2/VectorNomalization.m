function normalizedVector = VectorNomalization( vVector )
%VECTORNOMALIZATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
sumVector = sum(vVector);
if sumVector == 0
    sumVector = 1;
end
normalizedVector = vVector / sumVector;

end

