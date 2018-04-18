function dis = CalculateUAVDis(wall, position)
%CalculateSensorDis һ��ǽ��һ�����˻��ľ���
% ����һ��ǽ��һ�����˻��ľ��룬wall: [x1 y1 x2 y2],
% position: [x y]��������λ�á��ɽ���Ϊ���˻���λ��

%�������˻���ǽ������һ���������
vectorUAV2Point1 = [wall(1) - position(1), wall(2) - position(2)];
%�������˻���ǽ����һ���������
vectorUAV2Point2 = [wall(3) - position(1), wall(4) - position(2)];
%����ǽ������
vectorWall = [wall(3) - wall(1), wall(4) - wall(2)];

%����һ��������ǽ�������ڻ�
dotProduct1 = vectorUAV2Point1(1) * vectorWall(1) + vectorUAV2Point1(2) * vectorWall(2);
%������һ��������ǽ�������ڻ�
dotProduct2 = vectorUAV2Point2(1) * vectorWall(1) + vectorUAV2Point2(2) * vectorWall(2);

%��������ڻ�һ��һ����˵�����˻���ǽ�ķ�Χ�ڣ���ô������õ㵽�ߵľ�������ʾ
if(dotProduct1 * dotProduct2 <=0)
    %������ٳ��Ե�
    area = abs(vectorUAV2Point1(1) * vectorWall(2) - vectorUAV2Point1(2) * vectorWall(1));
    dis = area / sqrt(vectorWall(1)^2 + vectorWall(2)^2);    
else %��������ڻ������������������Ǹ�����˵�����˻���ǽ�ķ�Χ�⣬��ǽ�ľ�����Ǿ���ǽ����������������Ǹ�����
    dis1 = sqrt(vectorUAV2Point1(1)^2 + vectorUAV2Point1(2)^2);
    dis2 = sqrt(vectorUAV2Point2(1)^2 + vectorUAV2Point2(2)^2);
    dis = min(dis1, dis2);
end
end

