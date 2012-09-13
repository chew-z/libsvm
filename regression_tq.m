% This script takes mean returns of some alphas from M and forecasts mean returns 
% for some other alpha. Plots results.

stock = 1;
[x, y] = prepData(alphas, ret1, stock, num_alphas, num_dates-1);

[z,r] = svr(x,y);


figure(1); clf(1);
subplot(2,1,1); 
plot(r); 
title('Prediction error'); ylabel('RMSE');
subplot(2,1,2); 
plot(z);hold all;plot(y);
title('Predicted (z) vs. Observed (y)');
legend('predicted','observed');
