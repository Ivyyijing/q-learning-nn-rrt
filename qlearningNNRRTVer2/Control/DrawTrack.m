%������˻���ǰ��һ��
function h=DrawTrack(pState,cState, ax)

%pState,ǰһ��״̬��cState����ǰ״̬��ax:��Ҫ���Ƶ�����ϵ
hold on;
h = plot(ax, [pState.position(1,1), cState.position(1,1)], ...
    [pState.position(2,1), cState.position(2,1)], '-');
%plot(cState.position(1,1), cState.position(2,1), 'Marker','+', 'MarkerSize', 10);
hold off;
end
