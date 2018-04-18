function uavPath = GenerateUAVPath(nodeListRRT)
%GENERATEUAVPATH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ����RRT���������������˻�·��,
% ����uavPath·������Ϊһϵ�еĵ�

% Ԥ�ȷ����ڴ棬�ӿ��ٶ�
uavPath = zeros(length(nodeListRRT), 2);
currentNode = nodeListRRT{length(nodeListRRT)};
pointNo = 0;

% ����������������
while currentNode.pointer ~= 0
    pointNo = pointNo + 1;
    uavPath(pointNo, :) = currentNode.position;
    currentNode = nodeListRRT{currentNode.pointer};
end

% ������ʼ�ڵ�
pointNo = pointNo + 1;
uavPath(pointNo, :) = currentNode.position;
% ��ȡ·��
uavPath = uavPath(1 : pointNo, :);
% ��Ϊ�ǴӺ���ǰ����ģ����Խ�·����ת
uavPath = uavPath(end : -1 : 1, :);
end