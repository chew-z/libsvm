function Z = modsel2(y, x)
%
	best_rmse = 1.0;
	C =[1:1:3];
	epsilon = [1:1:3] / sqrt(length(y));
	noise = std(y);
	i = 1; j = 1;
	for C=0:5
	    for epsilon=0.5:0.5:4
	        cmd = ['-s 3 -t 0 -v 5 -h 0 -c ',num2str((10^C)*noise),' -p ',num2str(epsilon*noise/sqrt(length(y)))];
	        m = svmtrain(y, x, cmd);
	        if m < best_rmse 
	            best_rmse = m;
	        end    
	        disp(['C = ' num2str(C),' epsilon = ',num2str(epsilon) ' best RMSE = ' num2str(best_rmse)] )
	        Z(i,j) = m;	% if '-v x' m is rmse otherwise it is model
	        j = j+1;
	    end
	    j = 1;
	    i = i+1;
	end

	xlin = linspace(1,3,size(Z,2));
	ylin = linspace(1,4,size(Z,1));
	[X,Y] = meshgrid(xlin,ylin); 
	mesh(X,Y, Z);
	xlabel('epsilon'); ylabel('C');zlabel('RMSE');
	figure(gcf);
end