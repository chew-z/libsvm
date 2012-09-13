function rmse = rmse(y, z)
% rmse(y,z) - returns Root Mean Square Error

	rmse = sqrt(mean(y(:) - z(:)).^2);
end