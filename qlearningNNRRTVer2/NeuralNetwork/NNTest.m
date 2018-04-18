[x,t] = simplefit_dataset;
net = feedforwardnet(10);
net.trainParam.showWindow = false; 
net.trainParam.showCommandLine = false;
net = train(net,x,t);

% view(net)
y = net(x);

perf = perform(net,y,t)