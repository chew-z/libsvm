% Try different parametrs with SVR (C, epsilon)
% Early attempts to use libsvm. Not important.

y = M(62:end, 1);
numalphas = 25;
X = M(61:end-1,2:numalphas); 
% X = normalize(X);
forward_range = 20;	% range of attempted predictions 
N = floor(length(y)/2);
NN = N + forward_range;
x = X; clear X

i = 1;
for p=1:10:101
	% s - epsilon-SVR or nu-SVR, t - kernel(linear), h - shrinking, c - C, p - epsilon (for epsilon SVR)
	model = svmtrain(y(1:N), x(1:N,:), ['-s 3 -t 1 -c' num2str(p) '-p 0.1 -h 0']); 
	z = svmpredict(y(N+1:NN), x(N+1:NN,:), model);
	tmp = corrcoef(z, y(N+1:NN));
	r(i) = tmp(2); i = i+1;
end

% w = model.SVs' * model.sv_coef
% b = -model.rho
% zz = w * x(N+1:NN) + b % zz = z;

% figure(1); clf(1);
% subplot(2,1,1); 		
% title('Predicted (z) vs observed (y)'); xlabel('z'); ylabel('y');
% plot(z, y(N+1:NN), '.');
% subplot(2,1,2); 
% title('Absolute forecasting error');
% plot(abs((z-y(N+1:NN)) ./ y(N+1:NN)));

% It's not so easy with alphas. Non linear, not predictable
% Some are good predictors for the others some not
%

clear i x tmp NN N forward_range