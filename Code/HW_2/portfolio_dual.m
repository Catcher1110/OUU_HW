function [obj] = portfolio_dual(mu, Sigma, lambda)

rng default

options = sdpsettings('verbose',0,'solver','mosek');

theta = sdpvar(length(mu),1); %decision variables
delta = sdpvar(1,1);
e = ones(length(mu),1);

Dualobj = 1/(4*lambda)*((1-lambda)*mu + theta - delta*e)' ...
    * inv(Sigma) * ((1-lambda)*mu + theta - delta*e) + delta;
% Dual objective function

%generate the constraints

constraints = {};
constraints{end+1} = theta >= 0;

optimize([constraints{:}], Dualobj, options);

theta = double(theta);
delta = double(delta);

obj = 1/(4*lambda)*((1-lambda)*mu + theta - delta*e)' ...
    * inv(Sigma) * ((1-lambda)*mu + theta - delta*e) + delta;
end