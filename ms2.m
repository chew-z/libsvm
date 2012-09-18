N = 50;
stock = randi(num_stocks,N,1);

r_linear = zeros(3, N);
tic
for i =1:length(stock)
	[x, y] = prepData(alphas, ret1, stock(i), num_alphas, num_dates-1);
	if sum(all(x)) > 0	% skip if empty x matrix (means all NaN or no holdings in that stock)
		res = modsel_tq(double(y),double(x));
		r_linear(1,i) = res.RMSE;
		r_linear(2,i) = res.C;
		r_linear(3,i) = res.epsilon;
	end
end
elapsed = toc

pushover('Koniec', ['Minęło ' num2str(elapsed) ' s.'])
clear i N res 