function [p, r, tr, sv] = svr2(x, y, opt, backward, b, forward)
% svr(..) - support vector regression. trains svm and predicts y (returns) based on x (alpha positions)
% returns vector of predicted returns (p), libsvm RMSE for each prediction (r), average error (tr)
% Adjusts epsilon and  C dynamically
%  
if nargin < 3 
	opt.C = 1; 
	opt.epsilon = 0.2; 
end	% 
if nargin < 4, backward = 20; 	end			% 
if nargin < 5, b = backward+1; 	end			% here you start
if nargin < 6, forward  = 0;	end

	training_range = [-backward:-1];
	prediction_range = [0:forward];
	e = length(y) - forward; 				% here you finish
	r = zeros(length(y), 1);
	p = zeros(length(y), 1);
	sv = zeros(length(y), 1);				% number of SV's
	err = zeros(3,1); % [accuracy, MSE, corrcoeff]
	if isa(x,'single') & isa(y,'single')
		for i=b:e
			noise = std(y(training_range+i)) + eps;	% when volatility == 0; flat line
		    cmd = ['-s 3 -t 0 -c ' num2str(opt.C * noise) ' -p ' num2str(opt.epsilon * noise) ' -q'];
			model = svmtrain_chi2_float(y(training_range+i), x(training_range+i,:), cmd); 
			sv(i) =  model.totalSV;
			[z, err,~] = svmpredict_chi2_float(y(prediction_range+i), x(prediction_range+i,:), model);
			% r(i) = rmse(z, y(prediction_range+i));
			r(i) = err(2);	
			p(i) = z(1);
		end
	else
		for i=b:e
			noise = std(y(training_range+i)) + eps;	% when volatility == 0; flat line
			cmd = ['-s 3 -t 0 -c ' num2str(opt.C * noise) ' -p ' num2str(opt.epsilon * noise) ' -q'];
			model = svmtrain(y(training_range+i), x(training_range+i,:), cmd);
			sv(i) =  model.totalSV;
			[z, err,~] = svmpredict(y(prediction_range+i), x(prediction_range+i,:), model);
			% r(i) = rmse(z, y(prediction_range+i));
			r(i) = err(2);	
			p(i) = z(1);
		end
	end
	if forward == 0		% not vector of errors but total rmse/mape for entire loop
		tr = rmse(z,y); 
	else
		tr = rmse(p,y); % p is prediction y(t) unless we set otherwise in the code
	end	% not vector of errors but total rmse/mape for all predictions
end