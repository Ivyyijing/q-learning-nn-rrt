function boltzmanVector = VectorBoltzmann( vVector, temperature  )
%VECTORNOMALIZATION 此处显示有关此函数的摘要
%   此处显示详细说明
boltzmanVector = exp(vVector / temperature);

sumVector = sum(boltzmanVector);

boltzmanVector = boltzmanVector / sumVector;

end

