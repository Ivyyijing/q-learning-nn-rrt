function boltzmanVector = VectorBoltzmann( vVector, temperature  )
%VECTORNOMALIZATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
boltzmanVector = exp(vVector / temperature);

sumVector = sum(boltzmanVector);

boltzmanVector = boltzmanVector / sumVector;

end

