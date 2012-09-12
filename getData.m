clear all

load('interview_data.mat');
ret1 = data.ret1;
[num_stocks, num_dates] = size(ret1);
alphas = alpha_cube.values;
[num_alphas, num_stocks, num_dates] = size(alphas);

clear data alpha_cube