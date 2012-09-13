function res = transform(X, t)
%transform(X,t) - transforms vector or matrix of observations (removing outliers)
%rows - observations, cols - variables
	
	switch t
		case 0
			res = X;
		case 1
			[rows, cols] = size(X);
			tmp = sign(X(:)) .* sqrt(abs(X(:)));
			res = reshape(tmp, rows, cols);
		case 2
			[~, cols] = size(X);
			[zeros(1,cols); diff(X)];
		case 3	% this is tricky min at 0.0
			[rows, cols] = size(X);
			tmp = sign(X(:)+eps) .* log(abs(X(:))+eps); % eps in case we have zeros from NaNs or ...
			res = reshape(tmp, rows, cols);
		otherwise
			res = X;
	end
end