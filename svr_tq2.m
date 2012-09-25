function [z, r, tr, sv]  = svr_tq2(alphas, ret1, opt)
% svr_tq2(..) - predicts returns based on vector of alpha positions in that stock
% returns total error (tr), vector of svr errors (r), predicted returns (z)
%
	if nargin < 3
		opt. kernel = 2;			
		opt.C = C;	opt.epsilon = epsilon;
		opt.start_id = 1;
		opt.backward = 40; opt.lag = 1;
		opt.t = 0;	
	end
	[num_alphas, num_stocks, num_dates] = size(alphas);
	start_id = opt.start_id;					% 
	nd = num_dates-1;				% max num_dates - lag
	ns = num_stocks;				% num_stocks
	lag = opt.lag;						% 
	t = opt.t;							% transformation of X 0 - none 1 - sqrt

	z = zeros(nd, ns);
	r = zeros(nd, ns);	% vectors o rmse per prediction, per stock
	tr = zeros(ns,1);	% vector of rmse per stock
	sv = zeros(nd,ns);
	for stock = 1:ns
		[x, y] = prepData(alphas, ret1, stock, num_alphas, nd, start_id, lag, t);
		if sum(all(x)) > 0	% skip if empty x matrix (means all NaN or no holdings in that stock)
			stock
			[z(:,stock),r(:,stock), tr(stock), sv(:,stock)] = svr2(x, y, opt);	% pass options for svmtrain
			tr(stock);
		end
	end
end