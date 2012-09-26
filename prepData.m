function [x, y] = prepData(alphas, ret1, stock, num_alphas, window_size, start_id, lag, t)
%  prepData(..) - prepare data before svr ..  
%  x - alpha positions in stock, y - returns of a stock
%
if nargin < 4, num_alphas = 183; 	end
if nargin < 5, window_size = 880;	end		% num_dates - lag
if nargin < 6, start_id = 1;		end		%
if nargin < 7, lag = 1;				end		% lag from x to y
if nargin < 8, t = 0;				end		% transform(x) 0 - no, 1 - sqrt, 2 - ln, 3 - 0.5(t(i) + t(i-1))	

	range = [start_id:start_id+window_size-1];
	% (alpha, stock, day) 						% alpha holdings of stock on day
	X = alphas(:,stock,range);	
	X = double(X);								% convert to double
	X = reshape(X, num_alphas, window_size);	% flatten into two dimensions
	X = X';										% transpose 
	X(isnan(X)) = 0;							% set NaN -> zero  
	% X = outliers(X);							% remove outliers
	if t > 0, X = transform(X, t);	end			% transform X - remove outliers, average t-1, t-2, ...
	X = normalize(X);							% normalize
	% X(isnan(X)) = 0;							% set NaN -> zero again
	x = single(X);								% convert back to single to save memory
	% (stock, day)
	Y = ret1(stock, range+lag)';				% 
	Y(isnan(Y)) = 0;							% set NaN -> zero
	y = single(Y);
end