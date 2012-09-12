% This script takes mean returns of some alphas from M and forecasts mean returns 
% for some other alpha. Plots results.

forward_range = 3;							% range of attempted predictions 
window_size = 450;
start_id = 1;
lag = 1;									% lag 
range = [start_id:start_id+window_size-1];
stock = 10;
% (alpha, stock, day) 						% alpha holdings of stock on day
X = alphas(:,stock,range);	
X = double(X);								% convert to double
X = reshape(X, num_alphas, window_size);	% convert into two dimensions
X(isnan(X)) = 0;							% set NaN -> zero  
x = X';										% & x = normalize(X);
											% transform X, remove outliers, average t-1, t-2, ...
											% skip if X is full of zeros or NaNs
% (stock, day)
y = double(ret1(stock, range+lag))';		% convert to double and transform

N = floor(length(y)/2);
NN = N + forward_range;

r = zeros(forward_range, N);
p = zeros(2,N);
for i=1:N
	training_range = [1:N] + i;
	prediction_range = [N+1:NN] + i;
	model = svmtrain(y(training_range), x(training_range,:), ['-s 4 -t 0 -h 0']); % s - epsilon SVR, t - linear, h - shrinking
	z = svmpredict(y(prediction_range), x(prediction_range,:), model);

	r(:, i) = (z - y(prediction_range)) ./y(prediction_range) ;
	p(:, i) = [z(1); y(N+i)];
	% w = model.SVs' * model.sv_coef
	% b = -model.rho
	% zz = w * x(N+1:NN) + b % zz = z;
end

figure(1); clf(1);
subplot(2,1,1);
plot(r');
subplot(2,1,2); 		
plot(p(1,:)', p(2,:), '.');

% title('Predicted (z) vs observed (y)'); xlabel('z'); ylabel('y');
% plot(z, y(N+1:NN), '.');
% subplot(2,1,2); 
% title('Absolute forecasting error');
% plot(abs((z-y(N+1:NN)) ./ y(N+1:NN)));

%