% script for finding optimal C and epsilon
% all the parameters other beeing equal 
format long
tic;

result = [];

for C = -1:3
	for epsilon = -1
		tr = svr_tq2(alphas, ret1, 10^C, 10^epsilon);
		costf(tr)
		result = [result costf(tr)];
	end
end
elapsed = toc

pushover('Koniec',['Upłynęło: ' num2str(elapsed) 's.' ])

format short