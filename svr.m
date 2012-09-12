function [p, r] = svr(x, y)
% svr - 
N = 20;					% here you start 
forward_range = 3;
backward_range=15;
training_range = [N-backward_range:N];
prediction_range = [N+1:N+forward_range];

steps = length(y) - forward_range - N; 	% that many steps

r = zeros(forward_range, steps);
p = zeros(2,steps);
	for i=1:steps
		model = svmtrain(y(training_range+i), x(training_range+i,:), ['-s 4 -t 0 -h 0']); % s - epsilon SVR, t - linear, h - shrinking
		z = svmpredict(y(prediction_range+i), x(prediction_range+i,:), model);

		r(:, i) = (z - y(prediction_range)) ./y(prediction_range) ;
		p(:, i) = [z(1); y(N+i)];
	end
end	