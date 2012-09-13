function [p, r, tr] = svr(x, y, opt, backward, b, forward)
% svr(..) - support vector regression
%
if nargin < 3, opt = ['-s 4 -t 0 -h 0 -q']; end	% s - epsilon SVR, t - linear, h - shrinking, q - quiet
if nargin < 4, backward = 20; 	end			% 
if nargin < 5, b = backward+1; 	end			% here you start
if nargin < 6, forward  = 0;	end

	training_range = [-backward:-1];
	prediction_range = [0:forward];
	e = length(y) - forward; 					% here you finish
	r = zeros(length(y), 1);
	p = zeros(length(y), 1);
	err = zeros(3,1); % [accuracy, MSE, corrcoeff]
		for i=b:e
			model = svmtrain(y(training_range+i), x(training_range+i,:), opt); 
			[z, err,~] = svmpredict(y(prediction_range+i), x(prediction_range+i,:), model);
			% r(i) = rmse(z, y(prediction_range+i));
			r(i) = err(2);	
			p(i) = z(1);
		end
	if forward == 0		% not vector of errors but total rmse/mape for entire loop
		tr = rmse(z,y); 
	else
		tr = 0.0; 		% left for later
	end	% not vector of errors but total rmse/mape for all predictions
end