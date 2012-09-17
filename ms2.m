N = 10

stock = randi(4072,N);

r = zeros(3, N);
tic
for i =1:length(stock)

	[x, y] = prepData(alphas, ret1, stock(i), num_alphas, num_dates-1);
	Z = modsel_tq(double(y),double(x));
	r(1,i) = max(max(Z));
	r(2,i) = min(min(Z));
end
elapsed = toc
pushover('koniec', ['Minęło ' num2str(elapsed) ' s.'])

