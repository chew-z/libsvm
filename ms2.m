w = [0.29617;1.2008;1.0902;-0.3587;-0.12993;0.73374;0.12033;1.1363;-0.68677;0.47168];
	N = 250; 
	x = randn(N,10);
	y =x* w + 0.25*randn(N,1);

	Z = modsel2(y,x);
clear w N