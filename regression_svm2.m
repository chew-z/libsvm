% Another example of using SVM for linear regression
% This is better one

clear all

N = 1000; 
t = randn(N,10);
x = normalize(t);			% x is normalized t
w = randn(10, 1);			% random weights for multilinear regression

y = x * w + 0.1*randn(N,1);	% predicted variable % use t in place of x if you like

% train svm using first half of the data
model = svmtrain(y(1:N/2),x(1:N/2,:),['-s 4 -t 0 -h 0']);
% predict on the other half
z = svmpredict(y(N/2+1:end),x(N/2+1:end,:),model);
% get weights of 
w_svm = model.SVs' * model.sv_coef
b_svm = -model.rho
% display original weights
w

% plot predicted vs. original or whatever you like
figure('color','w'); plot(z, y(N/2+1:end), '.'); 
robustdemo(z, y(N/2+1:end))
% axis equal;axis square;
% figure('color','w'); plot(z - y(N/2+1:end), '.');
% figure('color','w');
% plot(x(1:N/2,:), y(1:N/2),'b.');
% hold on;
% plot(x(N/2+1:end,:), z, 'r.');
% legend('training','test');
% xlabel('x');
% ylabel('y');