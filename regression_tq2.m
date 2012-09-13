% This script takes positions of some all alphas in particular stock 
% and attempts to predicts return of that stocks. 
% Plots results.

nd = num_dates-1;		% max num_dates-1
ns = 100;				% num_stocks

r = zeros(nd, ns);
z = zeros(nd, ns);
for stock = 1:ns;
	[x, y] = prepData(alphas, ret1, stock, num_alphas, nd);
	if sum(all(x)) > 0	% avoid empty matrix (all NaN or no holdings in that stock)
		[z(:,stock),r(:,stock)] = svr(x,y);
	end
end

% figure(1); clf(1);
% subplot(2,1,1); 
% plot(r); 
% title('Prediction error'); ylabel('RMSE');
% subplot(2,1,2); 
% plot(z);hold all;plot(y);
% title('Predicted (z) vs. Observed (y)');
% legend('predicted','observed');
