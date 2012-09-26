function data = normalize(d)
% normalize(data) - scale before svm. Three different variants each giving different results
% the data is normalized so that max is 1, and min is 0 (-1)
% data = (d -repmat(min(d,[],1),size(d,1),1))*spdiags(1./(max(d,[],1)-min(d,[],1))',0,size(d,2),size(d,2));

% normD = range(d) + eps;          		% this is a vector
% normD = repmat(normD, [length(d) 1]); % this makes it a matrix
%                                       % of the same size as A
% data = d ./ normD;					% your normalized matrix

[rows,~] = size(d);%
colMax = max(abs(d)+eps,[],1);
data = d./repmat(colMax,rows,1);