function [x, y] = prepData(alphas, ret1, stock)
%  prepData 
%
	num_alphas = 25;
	window_size = 150;
	start_id = 1;
	lag = 1;						% lag 
	range = [start_id:start_id+window_size-1];
	% (alpha, stock, day) 				% alpha holdings of stock on day
	X = alphas(:,stock,range);	
	X = double(X);					% convert to double
	X = reshape(X, num_alphas, window_size);	% convert into two dimensions
	X(isnan(X)) = 0;				% set NaN -> zero  
	x = X';						% & x = normalize(X);
							% transform X, remove outliers, average t-1, t-2, ...
							% skip if X is full of zeros or NaNs
	% (stock, day)
	y = double(ret1(stock, range+lag))';		% convert to double and transform

end