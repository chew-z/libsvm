function mape = mape(y, z)
% mape(y,z) - returns Mean absolute error

	mape = mean((y(:) - z(:)) ./ y(:));
end