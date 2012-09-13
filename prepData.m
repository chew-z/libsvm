function [x, y] = prepData(alphas, ret1, stock, num_alphas, window_size, start_id, lag)
%  prepData(..) - prepare data for svr ..  
%  x - alpha positions in stock, y - returns of a stock
%
if nargin < 4, num_alphas = 183; 	end
if nargin < 5, window_size = 880;	end
if nargin < 6, start_id = 1;		end		%
if nargin < 7, lag = 1;				end		% lag from x to y

	range = [start_id:start_id+window_size-1];
	% (alpha, stock, day) 				% alpha holdings of stock on day
	X = alphas(:,stock,range);	
	X = double(X);					% convert to double
	X = reshape(X, num_alphas, window_size);	% convert into two dimensions
	X(isnan(X)) = 0;				% set NaN -> zero  
	x = X';							% & x = normalize(X);
									% transform X, remove outliers, average t-1, t-2, ...
									% skip if X is full of zeros or NaNs
	% (stock, day)
	y = double(ret1(stock, range+lag))';	% convert to double and transform
end