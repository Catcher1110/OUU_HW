function [prob] = wcprob()
yalmip clear
options = sdpsettings('verbose', 0, 'dualize', 0, 'solver', 'mosek');
alpha = sdpvar(1,1); % Decision Variables
gamma = sdpvar(2,1);
obj = -alpha - 0.1 * gamma(1) - 0.1 * gamma(2); % Objective Function
constraints = {}; % Constraints
constraints{end + 1} = alpha <= 1;
constraints{end + 1} = alpha + gamma(1) <= 0;
constraints{end + 1} = alpha + gamma(2) <= 0;
constraints{end + 1} = gamma <= 0;
optimize([constraints{:}], obj, options);
prob = -double(obj);
end