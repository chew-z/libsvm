function tr = svr_parfun(x, y, a)
% passes SVM parameters as a vector of variables a
% for optimization
	opt.gamma = a(1);
	opt.C = a(2); 
	opt.epsilon = a(3);
	opt.kernel =  2; 						% default kernel is rbf
	opt.backward = 40;						% 
	opt
	[~, ~, tr, ~] = svr2(x, y, opt);

end