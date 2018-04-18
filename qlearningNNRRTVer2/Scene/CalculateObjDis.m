%计算无人机距离目标的距离
function objDis = CalculateObjDis(positionUAV, positionObj)
%CALULATEOBJDIS 此处显示有关此函数的摘要
%   此处显示详细说明
objDis = (positionUAV(1) - positionObj(1))^2 + (positionUAV(2) - positionObj(2))^2;
objDis = sqrt(objDis);

end

