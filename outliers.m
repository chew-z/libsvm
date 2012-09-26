function res = outliers(d)
% One of attempts to remove outliers. But frankly, I don't like this code 
	z = 3;
	meanM = mean(d);
	sigmaM = std(d);

	meanMat = repmat(meanM,size(d,1),1);
	sigmaMat = repmat(sigmaM,size(d,1),1);
	
	Ceil = meanMat + z * sigmaMat;
	Floor = meanMat - z * sigmaMat;

	d((d - meanMat) < z * sigmaMat) = Floor((d - meanMat) < z * sigmaMat);
	d((d - meanMat) > z * sigmaMat) = Ceil((d - meanMat) > z * sigmaMat);
	
	res = d;

end