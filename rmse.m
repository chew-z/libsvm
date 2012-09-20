function rmse = rmse(y, z)
% rmse(y,z) - returns Root Mean Square Error
	X = (y(:) - z(:)).^2;
	X(isnan(X)) = 0;
	X(isinf(X)) = 0;
	rmse = sqrt(mean(X));
end