% script for running optimization from command line

% define objective as a function of variable a (SVR parameters gamma, C, epsilon)
f = @(a)svr_parfun(x, y, a)

% set optimization constrains

lb = [eps;eps;eps]

[a, fval, exitflag] = ga(f, 3,[],[],[],[],lb,[])

disp('Gamma ' num2str(a(1)) ' C ' num2str(a(2)) ' epsilon ' num2str(a(3)))

% 	opt.gamma = a(1);
% 	opt.C = a(2); 
% 	opt.epsilon = a(3);
% 	opt.kernel =  2; 						
% 	opt.backward = 40;
% [z, r, tr, sv] = svr2(x, y, opt);
% % plot(y);hold all;plot(z);
% xlabel('time'); ylabel('returns');
% title('Predicted vs observed returns')
% hold off