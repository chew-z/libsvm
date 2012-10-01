function res = modsel_tq2(y, x)
% modsel_tq2 - grid search for optimum values of gamma and C 
% other parameters like kernel, window size etc. are set explicite in a code (opt)
% returns some useful info like mape, rmse, number of support vectors, best parameters etc.
	best_mape = 100;
	best_rmse = 10;
	best_e = 0;
	best_C = 0;
	best_g = 0;
	best_sv = 0;
	min_g=-2; max_g=0;
	min_c=0.95; max_c=1.25;
	i = 1; j = 1;
    opt.kernel = 2;                     % kernel used (6 - chi2)
    opt.start_id = 1;                   % start of simulation
    opt.backward = 60; 
    opt.lag = 1;
    opt.t = 0;
    opt.gamma = 1/183;
    for gam = min_g:0.25:max_g;
		for C=min_c:0.05:max_c
	    	epsilon = 1;
	    	opt.gamma = 10^gam;
	    	opt.C = C;                          % C parameter of SVM
    		opt.epsilon = epsilon;              % epsilon parameter of SVM
			[z, r, tr, sv] = svr2(double(x),double(y), opt);
	        if tr < best_mape
	        	best_rmse = max(r); 
	            best_mape = tr;
	            best_e = epsilon;
	            best_C = C;
	            best_g = opt.gamma;
	            best_sv = mean(sv)/opt.backward;
	        end    
	        disp(['Gamma = ' num2str(opt.gamma) ' C = ' num2str(C),' epsilon = ',num2str(epsilon) ' nSV ' num2str(mean(sv)/opt.backward)])
	        disp(['best MAPE = ' num2str(best_mape) ' worst RMSE = ' num2str(best_rmse)] )
	        Z(i,j) = tr;	
	        j = j+1;
		end
	    j = 1;
	    i = i+1;
	end
	res.RMSE = best_rmse;
	res.MAPE = best_mape;
	res.gamma = best_g;
	res.C = best_C;
	res.epsilon = best_e;
	res.nSV = best_sv;
	res
end