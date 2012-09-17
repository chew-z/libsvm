% Another example of using SVM for linear regression
% This is better 

clear all
L = 1000; 
t = randn(L,10);
x = normalize(t);				% x is normalized t
w = randn(10, 1);				% random weights for multilinear regression

y = x * w + 0.25*randn(L,1);	% predicted variable % use t in place of x if you like
N = floor(length(y)/2);

for p=10:100
	% train svm using first half of the data
	% s - epsilon-SVR or nu-SVR, t - kernel(0-linear), h - shrinking, c - C, p - epsilon (for epsilon SVR)
	model = svmtrain(y(1:N),x(1:N,:),['-s 3 -t 0 -q -p ' num2str(1/p) ]);
	% predict on the other half
	z = svmpredict(y(N+1:end),x(N+1:end,:),model);
	tmp = corrcoef(z, y(N+1:end));
	r(p) = tmp(2);
end


% plot predicted vs. original or whatever you like
% figure('color','w'); 
% plot(z, y(N+1:end), '.'); 
% robustdemo(z, y(N/2+1:end))
