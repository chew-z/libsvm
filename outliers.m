function res = outliers(d)
% removes outliers
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