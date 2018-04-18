%会出无人机当前的一段
function h=DrawTrack(pState,cState, ax)

%pState,前一个状态，cState：当前状态，ax:需要绘制的坐标系
hold on;
h = plot(ax, [pState.position(1,1), cState.position(1,1)], ...
    [pState.position(2,1), cState.position(2,1)], '-');
%plot(cState.position(1,1), cState.position(2,1), 'Marker','+', 'MarkerSize', 10);
hold off;
end
