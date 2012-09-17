% script for finding optimal C and epsilon
% all the parameters other beeing equal 

% getData;
% matlabpool open
getenv('OMP_NUM_THREADS')

format long
tic;
backward = 20;
cost = [];
sv_t = [];
for C = 3
	for epsilon = 1
		[z, r, tr, sv] = svr_tq2(alphas, ret1, C, epsilon/sqrt(backward));
		costf(tr)
		cost = [cost costf(tr)];
		sv_t = [sv_t; mean(sv) / backward];
	end
end

elapsed = toc;
pushover('script.m koniec',['Upłynęło: ' num2str(elapsed) 's. Najlepszy wynik to ' num2str(min(cost)) ])

format short

clear C epsilon elapsed