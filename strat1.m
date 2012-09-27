
	getData

    opt.kernel = 2;     opt.gamma = 0.767;    % kernel used (6 - chi2), gamma
    opt.C = 1;          opt.epsilon = 0.02;   % C & epsilon parameter of SVM
    opt.start_id = 1;   opt.backward = 40;    % start of simulation and rolling window
    opt.lag = 1;        opt.t = 0;            % 

    for di=opt.backward+1
        evaluation_window=max(di-opt.backward+1,1):di;
        P = ret1(:, evaluation_window);
        CV = covm(P');  % using NaN Toolbox
        CV(isnan(CV)) = 0;
        M = zeros(1, num_stocks); 
		for stock = 1:num_stocks
			[x, y] = prepData(alphas, ret1, stock, num_alphas, di, opt.start_id, opt.lag, opt.t);
			[z, ~, ~, ~] = svr2(x, y, opt);
			M(stock) = z(di);
		end

		I = M ~=0;
		m = M(I);
		cv = double(CV(I,I));

		% [~, ~, ~, weight_tang] = tangency(m, cv, 5, 0.0);
		[i_tang, sharpe, Sigma, mu] = ef2(m, cv, 0, 5, 0.00001);
		% [sharpe, sigma, mu] = minvar(m, cv);
		% n = length(mu);
		% iS = pinv(cv);
		% weights = (iS * ones(n,1)) / (ones(1,n) * iS * ones(n,1));
		% w = zeros(num_stocks,1);
		% w(I) = weights;
    end

    clear P stock di evaluation_window