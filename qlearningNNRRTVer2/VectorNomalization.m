function normalizedVector = VectorNomalization( vVector )
%VECTORNOMALIZATION 此处显示有关此函数的摘要
%   此处显示详细说明
sumVector = sum(vVector);
if sumVector == 0
    sumVector = 1;
end
normalizedVector = vVector / sumVector;

end

