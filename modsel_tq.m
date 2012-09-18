function res = modsel_tq(y, x)
%
	best_rmse = 1;
	best_e = 0;
	best_C = 0;
	noise = std(y);
	min_c=1.0;max_c=5;
	min_e=0.25; max_e=3;
	i = 1; j = 1;
	for C=min_c:0.5:max_c;
	    for epsilon=min_e:0.25:max_e
	        cmd = ['-s 3 -t 0 -v 20 -q -c ',num2str(C*noise),' -p ',num2str(epsilon*noise/sqrt(length(y)))]
	        m = svmtrain(y, x, cmd);
	        if m < best_rmse 
	            best_rmse = m;
	            best_e = epsilon;
	            best_c = C;
	        end    
	        disp(['C = ' num2str(C),' epsilon = ',num2str(epsilon) ' best RMSE = ' num2str(best_rmse)] )
	        Z(i,j) = m;	% if '-v x' m is rmse otherwise it is model
	        j = j+1;
	    end
	    j = 1;
	    i = i+1;
	end
	res.RMSE = min(min(Z));
	res.C = best_c;
	res.epsilon = best_e;

	res

	% plot 
	ylin = linspace(min_c,max_c,size(Z,1));
	xlin = linspace(min_e,max_e,size(Z,2));
	[X,Y] = meshgrid(xlin,ylin); 
	mesh(X,Y, Z);
	xlabel('epsilon'); ylabel('C');zlabel(['RMSE - stock ' ]);
	figure(gcf);
end