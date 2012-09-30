function [ final_alpha alpha_weights_matrix] = stratTest()
% sample strategy 
    
    file_name = '20090102_20120629_nostockpnl.mat';
    opt.kernel = 2;     opt.gamma = 0.767;    % kernel used (6 - chi2), gamma
    opt.C = 1;          opt.epsilon = 0.02;   % C & epsilon parameter of SVM
    opt.start_id = 801;   opt.backward = 40;    % start of simulation and rolling window
    opt.lag = 1;        opt.t = 0;            %  
    % get data from data & alpha_cube.values
    %get a handle to the HDF5 filesystem
    fileinfo = h5info(file_name);
    % stock returns (= predicted variable y)
    ret1=h5read(file_name,'/data/ret1');
    [num_stocks1, num_dates1] = size(ret1);
    % alphas positions in that stock (= observed variable x)
    alphas=h5read(file_name,'/alpha_cube/values');
    [num_alphas, num_stocks, num_dates] = size(alphas);
    if (num_stocks ~= num_stocks1 | num_dates ~= num_dates1)
        warning('getData: dimensions of ret1 and alphas not equal.')''
    end
    % 
    alpha_weights_matrix = zeros(num_stocks, num_dates);
    final_alpha = zeros(num_stocks, num_dates);
    tic
    for di=opt.start_id:num_dates-1
        disp(['Step ' num2str(di)])
        evaluation_window=max(di-opt.backward+1,1):di;
        P = ret1(:, evaluation_window);
        CV = covCor(P');  % 
        CV(isnan(CV)) = 0;
        M = zeros(1, num_stocks); 
        for stock = 1:num_stocks
            [x, y] = prepData(alphas, ret1, stock, num_alphas, opt.backward, di-opt.backward, opt.lag, opt.t);
            [z, ~, ~, ~] = svr2(x, y, opt);
            M(stock) = z(di);
        end

        I = M ~=0;
        m = M(I);
        cv = double(CV(I,I));
        % portopt(m, cv, 5)     % This is really slow
        % [~, ~, ~, w_tang] = tangency(m, cv, 5, 0.0);
        [w_tang, ~, ~, ~, ~] = ef2(m, cv, 0, 5, 0.00001);
        alpha_weights_matrix(I, di) = w_tang;
    end
    elapsed = toc
    pushover('Koniec testu', ['Minęło ' num2str(elapsed) ' s.'])
    final_alpha = single(alpha_weights_matrix);
end
