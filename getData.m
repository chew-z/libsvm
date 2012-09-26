% This script loads simply the data, extracts stock holdings (alphas) and stock returns(ret1)
% clears unused variables to save memory
clear all

load('20090102_20120629_nostockpnl.mat');
ret1 = data.ret1;
[num_stocks1, num_dates1] = size(ret1);
alphas = alpha_cube.values;
[num_alphas, num_stocks, num_dates] = size(alphas);

if (num_stocks ~= num_stocks1 | num_dates ~= num_dates1)
	warning('getData: dimensions of ret1 and alphas not equal.')''
end

clear data alpha_cube num_stocks1 num_dates1