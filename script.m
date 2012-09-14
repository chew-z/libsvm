% script for finding optimal C and epsilon
% all the parameters other beeing equal 

% getData;
% matlabpool open

format long
tic;

cost = [];
err = [];
pred = [];
for C = -2
	for epsilon = -1
		[tr, r, z] = svr_tq2(alphas, ret1, 10^C, 10^epsilon);
		costf(tr)
		cost = [cost costf(tr)];
		err = [err r];
		pred = [pred z];
	end
end

elapsed = toc;
pushover('script.m koniec',['Upłynęło: ' num2str(elapsed) 's. Najlepszy wynik to ' num2str(min(cost)) ])

format short

clear C epsilon tr r elapsed