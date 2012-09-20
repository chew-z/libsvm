function res = costf(x)
% costf(..) - cost function of svr run for entire dataset
% sum of all non-zero errors (rmse) per each stock - zero = zero matrix (skipped) 

	res = sum(x) / sum(x~=0);
end