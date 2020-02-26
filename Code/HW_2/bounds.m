function [lower, upper] = bounds(t)
rng default

options = sdpsettings('verbose',0,'solver','mosek');

c = [zeros(t-1, 1); ones(9-t+1, 1)];
x = sdpvar(9,1); %decision variables

obj = c' * x; % objective function

%generate the constraints
constraints = {};
constraints{end+1} = x >= 0;
constraints{end+1} = sum(x) == 1;

mean = (1:9) * x;
constraints{end+1} = mean == 3;
variance = (-2:6).^2 * x;
constraints{end+1} = variance == 4;

optimize([constraints{:}], obj, options);
lower = double(obj);

optimize([constraints{:}], -obj, options);
upper = double(obj);

end