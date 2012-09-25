
% % set variables

% alpha_values = alpha_cube.values;    % consists of alpha values per alpha, per stock, per day
% alpha_values(~isfinite(alpha_values)) = 0; 
% % alpha_simres = alpha_cube.simres;    % consists of alpha performances

% clear alpha_cube

% num_alphas = size(alpha_values,1);    % number of alphas
% num_stocks = size(alpha_values,2);    % number of stocks
% num_dates = size(alpha_values,3);     % number of days

% normalize alpha weights
sum_weights = nansum(abs(z'), 1);
alpha_weights_matrix = z' ./ repmat(sum_weights, [num_stocks,1]);


% then cap
max_weight=.1;   % maximum alpha weight is 10% of all weights
over_weight = (alpha_weights_matrix > max_weight);
alpha_weights_matrix(over_weight) = max_weight;
alpha_weights_matrix(~isfinite(alpha_weights_matrix)) = 0;

clear over_weight sum_weights max_weight

% final alpha is lc of alpha values and alpha weights
final_alpha = single(alpha_weights_matrix);

clear alpha_weights_matrix alpha_values
