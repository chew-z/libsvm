function [tr, r, z]  = svr_tq2(alphas, ret1, C, epsilon)
% svr_tq2(..) - predicts returns based on vector of alpha positions in that stock
% returns total error (tr), vector of svr errors (r), predicted returns (z)
%
	[num_alphas, num_stocks, num_dates] = size(alphas);
	start_id = 1;					% 
	nd = num_dates-1;				% max num_dates - lag
	ns = num_stocks;				% num_stocks
	lag = 1;						% 
	t = 1;							% transformation of X 0 - none 1 - sqrt
	if nargin < 3, C = 1;			end
	if nargin < 4, epsilon = 0.1;	end

	cmd = ['-s 3 -t 0 -h 0 -q' ' -c ' num2str(C) ' -p ' num2str(epsilon) ]

	z = zeros(nd, ns);
	r = zeros(nd, ns);	% vectors o rmse per prediction, per stock
	tr = zeros(ns,1);	% vector of rmse per stock
	for stock = 1:ns
		[x, y] = prepData(alphas, ret1, stock, num_alphas, nd, start_id, lag, t);
		if sum(all(x)) > 0	% skip if empty x matrix (means all NaN or no holdings in that stock)
			[z(:,stock),r(:,stock), tr(stock)] = svr(x, y, cmd);	% pass options for svmtrain
		end
	end
	% res = tr;
end