function [M CV] = stratTest()
% sample strategy 
    
    file_name = '20090102_20120629_nostockpnl.mat';
    
    opt.kernel = 2;     opt.gamma = 0.767;    % kernel used (6 - chi2), gamma
    opt.C = 1;          opt.epsilon = 0.02;   % C & epsilon parameter of SVM
    opt.start_id = 1;   opt.backward = 40;    % start of simulation and rolling window
    opt.lag = 1;        opt.t = 0;            %  

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

    for di=opt.start_id+1:num_dates
        evaluation_window=max(di-opt.backward+1,1):di;
        P = ret1(:, evaluation_window);
        CV = cov(P'); 
    end

    % [z, ~, ~, ~] = svr_tq2(alphas, ret1, opt);      % z = returns predicted by SVM
    % M = zeros(num_dates,num_alphas);              % mean returns
    % M = [zeros(1,num_stocks); z];
    M = zeros(1,num_stocks);
    % alpha_weights_matrix = zeros(num_stocks, num_dates); % consists of alpha weights per alpha, per day
    % % normalize alpha weights
    % sum_weights = nansum(abs(M'), 1);
    % alpha_weights_matrix = M' ./ repmat(sum_weights, [num_stocks,1]);
    % % then cap
    % max_weight=.1;   % maximum alpha weight is 10% of all weights
    % over_weight = (alpha_weights_matrix > max_weight);
    % alpha_weights_matrix(over_weight) = max_weight;
    % alpha_weights_matrix(~isfinite(alpha_weights_matrix)) = 0;
    % % final alpha 
    % final_alpha = single(alpha_weights_matrix);

end
