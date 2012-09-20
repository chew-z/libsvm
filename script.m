% script for finding optimal C and epsilon
% all the parameters other beeing equal 

% getData;
% matlabpool open
getenv('OMP_NUM_THREADS')

format long
tic;
backward = 20;
cost = [];
sv_t = [];
for C = 1
	for epsilon = 1
		[z, r, tr, sv] = svr_tq2(alphas, ret1, C, epsilon/sqrt(backward));
		costf(tr)
		cost = [cost costf(tr)];
		sv_t = [sv_t; mean(sv) / backward];
	end
end

elapsed = toc;
pushover('script.m koniec',['Upłynęło: ' num2str(elapsed) 's. Najlepszy wynik to ' num2str(min(cost)) ])

% normalize alpha weights
sum_weights = nansum(abs(z'), 1);
alpha_weights_matrix = z' ./ repmat(sum_weights, [4722,1]);
% then cap
max_weight=.1;   % maximum alpha weight is 10% of all weights
over_weight = (alpha_weights_matrix > max_weight);
alpha_weights_matrix(over_weight) = max_weight;
alpha_weights_matrix(~isfinite(alpha_weights_matrix)) = 0;
% final alpha 
final_alpha = single(alpha_weights_matrix);
clear over_weight sum_weights max_weight
clear alpha_weights_matrix alpha_values

load('20090102_20120629_nostockpnl.mat');


[simres] = op_simulate(data, final_alpha);
clear data 

format short
clear C epsilon elapsed