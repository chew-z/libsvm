% This script simply loads the data, extracts stock holdings (alphas) and stock returns(ret1)
% clears unused variables to save memory
clear all

% load('20090102_20120629_nostockpnl.mat');
%get a handle to the HDF5 filesystem
fileinfo = h5info('20090102_20120629_nostockpnl.mat');

ret1=h5read('20090102_20120629_nostockpnl.mat','/data/ret1');
% ret1 = data.ret1;
[num_stocks1, num_dates1] = size(ret1);
% alphas = alpha_cube.values;
alphas=h5read('20090102_20120629_nostockpnl.mat','/alpha_cube/values');
[num_alphas, num_stocks, num_dates] = size(alphas);

if (num_stocks ~= num_stocks1 | num_dates ~= num_dates1)
	warning('getData: dimensions of ret1 and alphas not equal.')''
end

clear num_stocks1 num_dates1 fileinfo
% clear data alpha_cube