% script for running optimization from command line

% define objective as a function of variable a (SVR parameters gamma, C, epsilon)
f = @(a)svr_parfun(x, y, a)

% set optimization constrains

lb = [eps;0;0]

[x fval, exitflag] = ga(f, 3,[],[],[],[],lb,[])