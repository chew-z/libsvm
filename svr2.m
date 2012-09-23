function [p, r, tr, sv] = svr2(x, y, opt, b, forward)
% svr(..) - support vector regression. trains svm and predicts y (returns) based on x (alpha positions)
% returns vector of predicted returns (p), libsvm RMSE for each prediction (r), average error (tr)
% Adjusts epsilon and  C dynamically
%  
if nargin < 3 
	opt.C = 1; 
	opt.epsilon = 1;
	opt.gamma = 0.05;
	opt.kernel =  2; 						% default kernel is rbf
	opt.backward = 20;
end	% 
backward = opt.backward; 					% 
if nargin < 4, b = backward+1; 	end			% here you start
if nargin < 5, forward  = 0;	end

	training_range = [-backward:-1];
	prediction_range = [0:forward];
	e = length(y) - forward; 				% here you finish
	r = zeros(length(y), 1);
	p = zeros(length(y), 1);
	sv = zeros(length(y), 1);				% number of SV's
	err = zeros(3,1); % [accuracy, MSE, corrcoeff]
	if isa(x,'single') & isa(y,'single')
		for i=b:e
			med = mean(y(training_range+i));
			noise = std(y(training_range+i)) + eps;	% when volatility == 0; flat line
			C = max([abs(med + 2* noise), abs(med - 3 * noise)]);
		    cmd = ['-s 3 -t ' num2str(opt.kernel) ' -g ' num2str(opt.gamma) ' -c ' num2str(opt.C * C) ' -p ' num2str(noise * opt.epsilon /sqrt(backward)) ' -q'];
			model = svmtrain_chi2_float(y(training_range+i), x(training_range+i,:), cmd); 
			sv(i) =  model.totalSV;
			[z, err,~] = svmpredict_chi2_float(y(prediction_range+i), x(prediction_range+i,:), model);
			% r(i) = rmse(z, y(prediction_range+i));
			r(i) = err(2);	
			p(i) = z(1);
		end
	else
		for i=b:e
			med = median(y(training_range+i));
			noise = std(y(training_range+i)) + eps;	% when volatility == 0; flat line
			C = max([abs(med + 2* noise), abs(med - 3 * noise)]);
			cmd = ['-s 3 -t ' num2str(opt.kernel) ' -g ' num2str(opt.gamma) ' -c ' num2str(opt.C * C) ' -p ' num2str(noise * opt.epsilon /sqrt(backward)) ' -q'];
			model = svmtrain(y(training_range+i), x(training_range+i,:), cmd);
			sv(i) =  model.totalSV;
			[z, err,~] = svmpredict(y(prediction_range+i), x(prediction_range+i,:), model);
			% r(i) = rmse(z, y(prediction_range+i));
			r(i) = err(2);	
			p(i) = z(1);
		end
	end
	if forward == 0		% not vector of errors but total rmse/mape for entire loop
		tr = mape(z,y); 
	else
		tr = mape(p,y); % p is prediction y(t) unless we set otherwise in the code
	end	% not vector of errors but total rmse/mape for all predictions
end