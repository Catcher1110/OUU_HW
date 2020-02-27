clear all
yalmip clear

rng default

options = sdpsettings('verbose',1,'solver','mosek');

N = 3; %number of assets
mu = [10; 20; 30]; %mean returns
sigma = 0.3*mu; %standard deviations

corr_mat = gallery('randcorr',N); %correlation matrix
Sigma = diag(sigma)*corr_mat*diag(sigma);

lambda = 0.5;

x = sdpvar(N,1); %decision variables

obj = -lambda*x'*Sigma*x + (1-lambda)*mu'*x;  %objective function

%generate the constraints

constraints = {};
constraints{end+1} = x >= 0;
constraints{end+1} = sum(x) == 1;

optimize([constraints{:}], -obj, options);

x = double(x);
variance = (x'*Sigma*x);
mean = (mu'*x);

fprintf('mean return: %f, variance: %f \n', mean, variance);


