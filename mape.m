function mape = mape(y, z)
% mape(y,z) - returns Mean absolute error 
% y = realized and z = predicted values
	X = abs((y(:) - z(:)) ./ y(:));
	X(isnan(X)) = 0;
	X(isinf(X)) = 0;
	mape = mean(X);
end