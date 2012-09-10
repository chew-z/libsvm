% This script takes mean returns of some alphas from M and forecasts mean returns 
% for some other alpha. Plots results.

x = M(61:end-1,2); x = normalize(x);
y = M(62:end,  1);
N = floor(length(y)/2);

model = svmtrain(y(1:N), x(1:N,:), ['-s 4 -t 0 -h 0']); % s - epsilon SVR, t - linear, h - shrinking
z = svmpredict(y(N+1:end), x(N+1:end,:), model);
tmp = corrcoef(z, y(N+1:end));
r = tmp(2);

w = model.SVs' * model.sv_coef
b = -model.rho
% zz = w * x(N+1:end) + b % zz = z;

figure('color','w'); 
plot(z, y(N+1:end), '.');
xlabel('z'); ylabel('y'); 

% It's not so easy with alphas. Non linear, not predictable
% 
%