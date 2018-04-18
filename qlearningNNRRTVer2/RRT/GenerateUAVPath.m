function uavPath = GenerateUAVPath(nodeListRRT)
%GENERATEUAVPATH 此处显示有关此函数的摘要
%   此处显示详细说明
% 根据RRT点列生成最后的无人机路径,
% 这里uavPath路径表现为一系列的点

% 预先分配内存，加快速度
uavPath = zeros(length(nodeListRRT), 2);
currentNode = nodeListRRT{length(nodeListRRT)};
pointNo = 0;

% 按索引遍历搜索树
while currentNode.pointer ~= 0
    pointNo = pointNo + 1;
    uavPath(pointNo, :) = currentNode.position;
    currentNode = nodeListRRT{currentNode.pointer};
end

% 加入起始节点
pointNo = pointNo + 1;
uavPath(pointNo, :) = currentNode.position;
% 截取路径
uavPath = uavPath(1 : pointNo, :);
% 因为是从后往前加入的，所以将路径反转
uavPath = uavPath(end : -1 : 1, :);
end