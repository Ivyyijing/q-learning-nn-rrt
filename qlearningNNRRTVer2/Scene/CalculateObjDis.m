%�������˻�����Ŀ��ľ���
function objDis = CalculateObjDis(positionUAV, positionObj)
%CALULATEOBJDIS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
objDis = (positionUAV(1) - positionObj(1))^2 + (positionUAV(2) - positionObj(2))^2;
objDis = sqrt(objDis);

end

