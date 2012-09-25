% script for finding optimal C and epsilon
% all other parameters beeing equal 

% getData;
% matlabpool open
% getenv('OMP_NUM_THREADS')

y = double(ret1(1,2:end)');
kernel = [0,1,2,6];
opt.backward = 60;
min_c=0.5;	max_c=2;
min_e=0.5;	max_e=2;
tic;
for k = 1:length(kernel)
	opt. kernel = kernel(k);
	filename = ['kernel_' num2str(opt.kernel) '.png'];
	i = 1; j = 1;
	sv_t = [];
	best_z = zeros(880,1);
	best_mape = 10;
	for C = min_c:0.5:max_c
		for epsilon = min_e:0.25:max_e
			opt.C = C;
			opt.epsilon = epsilon;
			[z, ~, ~, sv] = svr_tq2(alphas, ret1, opt);
			sv_t = [sv_t; mean(sv) / opt.backward];
			if mape(y,z) < best_mape
				best_mape = mape(y,z);
				best_z = z;
			end	
			% disp(['C ' num2str(C) ' Epsilon ' num2str(epsilon)])
			% disp(['MAPE ' num2str(mape(y,z)) '. RMSE ' num2str(rmse(y,z))] )
			% disp(['Accuracy ' num2str( length(y(sign(z) == sign(y))) ) '/' num2str(length(y) ) ])
			Z(i,j) = mape(y,z);
		    j = j+1;
		end
		j = 1;
		i = i+1;
	end
	z = best_z;
	disp(['Kernel ' num2str(opt.kernel) '. Najlepszy wynik to ' num2str(100*best_mape) ])
	disp(['Accuracy ' num2str( length(y(sign(z) == sign(y))) ) '/' num2str(length(y) ) ])
	sv_t = reshape(sv_t,size(Z,1), size(Z,2))
	ylin = linspace(min_c,max_c,size(Z,1));
	xlin = linspace(min_e,max_e,size(Z,2));
	[X,Y] = meshgrid(xlin,ylin);
	figure(1); 
	subplot(2,1,1)
	mesh(X,Y, Z);
	xlabel('epsilon'); ylabel('C');zlabel(['MAPE' ]);
	subplot(2,1,2)
	plot(y);hold all;plot(z);
	title(['Kernel ' num2str(opt.kernel) '. Predicted returns (z) vs observed (y)']);
	xlabel('time'); ylabel('returns');
	hold off
	h = gcf;
	print(h,'-dpng',filename);

end
toc
clear C epsilon elapsed i j k kernel sv max_c min_c max_e min_e opt best_z best_mape
clear filename h ylin xlin X Y Z