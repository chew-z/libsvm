% This script takes mean returns of some alphas from M and forecasts mean returns 
% for some other alpha. Plots results.

forward_range = 3;				% range of attempted predictions 
% window_size = 450;
% start_id = 1;
lag = 1;						% lag 
[x, y] = prepData(alphas, ret1, 1);

[p,r] = svr(x,y);

figure(1); clf(1);
subplot(2,1,1);
plot(r');
subplot(2,1,2); 		
plot(p(1,:)', p(2,:), '.');

% title('Predicted (z) vs observed (y)'); xlabel('z'); ylabel('y');
% plot(z, y(N+1:NN), '.');
% subplot(2,1,2); 
% title('Absolute forecasting error');
% plot(abs((z-y(N+1:NN)) ./ y(N+1:NN)));

%