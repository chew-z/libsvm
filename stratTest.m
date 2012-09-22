% function [ final_alpha alpha_weights_matrix z] = stratTest(data, alpha_cube)
% sample strategy 

    ret1 = data.ret1;
    [num_stocks1, num_dates1] = size(ret1);
    alphas = alpha_cube.values;
    [num_alphas, num_stocks, num_dates] = size(alphas);

    if (num_stocks ~= num_stocks1 | num_dates ~= num_dates1)
        warning('getData: dimensions of ret1 and alphas not equal.')''
    end
    clear data alpha_cube num_stocks1 num_dates1

    opt.kernel = 6;                     % kernel used (6 - chi2)
    opt.C = 1;                          % C parameter of SVM
    opt.epsilon = 1;                    % epsilon parameter of SVM
    opt.start_id = 1;                   % start of simulation
    opt.backward = 40; 
    opt.lag = 1;
    opt.t = 0;
    [z, ~, ~, ~] = svr_tq2(alphas, ret1, opt);      % z = returns predicted by SVM
    % M = zeros(num_dates,num_alphas);                % mean returns
    CV = zeros(num_alphas, num_alphas, num_dates);  % covariance matrix 
    M = [zeros(1,num_alphas); z];
    alpha_weights_matrix = zeros(num_alphas, num_dates); % consists of alpha weights per alpha, per day
    % normalize alpha weights
    sum_weights = nansum(abs(M'), 1);
    alpha_weights_matrix = M' ./ repmat(sum_weights, [num_stocks,1]);
    % then cap
    max_weight=.1;   % maximum alpha weight is 10% of all weights
    over_weight = (alpha_weights_matrix > max_weight);
    alpha_weights_matrix(over_weight) = max_weight;
    alpha_weights_matrix(~isfinite(alpha_weights_matrix)) = 0;
    % final alpha 
    final_alpha = single(alpha_weights_matrix);

% end
