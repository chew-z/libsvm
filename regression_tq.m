% This script takes mean returns of some alphas from M and forecasts mean returns 
% for some other alpha. Plots results.
tic;
stock = 188;
[x, y] = prepData(alphas, ret1, stock, num_alphas, num_dates-1);

backward = 20;
opt.C = 3;
opt.epsilon = 1 / sqrt(backward);

[z, r, tr, sv] = svr2(x, y, opt, backward);

max(r)
tr
mean(sv) / backward
toc

figure(1); clf(1);
subplot(2,1,1); 
plot(r); 
title('Prediction error'); ylabel('RMSE');
subplot(2,1,2); 
plot(z);hold all;plot(y);
title('Predicted (z) vs. Observed (y)');
legend('predicted','observed');

