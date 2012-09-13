function [p, r] = svr(x, y, backward, b, forward)
% svr(..) - support vector regression
%
if nargin < 3, backward = 15; 	end
if nargin < 4, b = backward+1; 	end			% here you start 
if nargin < 5, forward  = 0;	end
training_range = [-backward:-1];
prediction_range = [0:forward];
e = length(y) - forward; 					% here you finish

r = zeros(length(y), 1);
p = zeros(length(y), 1);
	for i=b:e
		model = svmtrain(y(training_range+i), x(training_range+i,:), ['-s 4 -t 0 -h 0']); % s - epsilon SVR, t - linear, h - shrinking
		z = svmpredict(y(prediction_range+i), x(prediction_range+i,:), model);

		r(i) = rmse(z, y(prediction_range+i));
		p(i) = z(1);
	end
end	