function [ final_alpha] = stratTest3(filename)
% stratTest3 - 2012-10-03 - final_alpha (stock weights in portfolio) ~ predicted stock returns
% using SVR.
%  
% 
    if nargin < 1
        file_name = '20090102_20120629_nostockpnl.mat';
    end
    opt.kernel = 2;     opt.gamma = 0.767;    % kernel used (6 - chi2), gamma
    opt.C = 1;          opt.epsilon = 0.02;   % C & epsilon parameter of SVM
    opt.start_id = 861; opt.backward = 40;   % start of simulation and rolling window
    opt.lag = 1;        opt.t = 0;            %  
    % get data from data & alpha_cube.values
    %get a handle to the HDF5 filesystem
    fileinfo = h5info(file_name);
    % stock returns (= predicted variable y)
    ret1=h5read(file_name,'/data/ret1');
    [num_stocks1, num_dates1] = size(ret1);
    % alphas positions in that stock (= observed variable x)
    alphas=h5read(file_name,'/alpha_cube/values');
    [num_alphas, num_stocks, num_dates] = size(alphas);
    if (num_stocks ~= num_stocks1 | num_dates ~= num_dates1)
        warning('getData: dimensions of ret1 and alphas not equal.')''
    end
    % 
    % alpha_weights_matrix = zeros(num_stocks, num_dates);
    final_alpha = zeros(num_stocks, num_dates);
    % find portfolio weights in timesteps
    tic
    for di=opt.start_id:num_dates-opt.lag
        disp(['Step ' num2str(di)])
        tStart = tic;
        % evaluation_window=max(di-opt.backward+1,1):di;
        % P = ret1(:, evaluation_window);
        % CV = covCor(P');  % 
        % CV(isnan(CV)) = 0;
        M = zeros(1, num_stocks); 
        for stock = 1:num_stocks
            [x, y] = prepData(alphas, ret1, stock, num_alphas, opt.backward+opt.lag, di-opt.backward, opt.lag, opt.t);
            [z, ~, ~, ~] = svr2(x, y, opt);
            M(stock) = z(end);  % predicted values are returned at the end of vector z (not clear, re-factor)
        end
        % lower the dimensionality removing irrelevant stocks
        % I = M ~=0;
        % m = M(I);
        % cv = double(CV(I,I));
        % % portopt(m, cv, 5)     % This is really slow
        % % [~, ~, ~, w_tang] = tangency(m, cv, 5, 0.0);
        % [w_tang, ~, ~, ~, ~] = ef2(m, cv, 0, 5, 0.00001);
        final_alpha(:, di) = M;
        tElapsed = toc(tStart)
        % pushover('Timestep finished', ['Passed ' num2str(tElapsed) ' s.'])
    end
    elapsed = toc
    pushover('stratTest3 finished', ['Passed ' num2str(elapsed) ' s.'])
    sum_weights = nansum(final_alpha,1);
    final_alpha = final_alpha ./ repmat(sum_weights,[num_stocks,1]);
    final_alpha = single(final_alpha);
end
