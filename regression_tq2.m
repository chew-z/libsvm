% This script takes positions of all alphas in particular stock 
% and attempts to predicts return of that stocks. 
% Plots results.

nd = 50;		% max num_dates-1
ns = 10;		% num_stocks
start_id = 1;
lag = 1;
t = 0;	
C = 1;
epsilon = 0.1;

cmd = ['-s 4 -t 0 -h 0 -q' ' -c ' num2str(C) ' -p ' num2str(epsilon) ]

z = zeros(nd, ns);
r = zeros(nd, ns);	% vectors o rmse per prediction, per stock
tr = zeros(ns,1);	% vector of rmse per stock
for stock = 1:ns;
	[x, y] = prepData(alphas, ret1, stock, num_alphas, nd, 1, 1, t);
	if sum(all(x)) > 0	% skip if empty x matrix (means all NaN or no holdings in that stock)
		[z(:,stock),r(:,stock), tr(stock)] = svr(x, y);	% pass options for svmtrain
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

clear stock t lag start_id ns nd