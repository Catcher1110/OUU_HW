function [w,b]=ccp(epsilon)
yalmip clear
load('data.mat');
y = cell2mat(y);
[m, ] = size(y);
options = sdpsettings('verbose', 1, 'dualize', 0, 'solver', 'mosek');
w = sdpvar(m,1);
b = sdpvar(1,1);
t = intvar(N,1);
obj = 0;
constraints = {};
constraints{end + 1} = w <= 100 * ones(2,1);
constraints{end + 1} = w >= -100 * ones(2,1);
constraints{end + 1} = w <= 100 * ones(2,1);
constraints{end + 1} = w >= -100 * ones(2,1);
constraints{end+1} = b <= 100;
constraints{end+1} = b >= -100;
constraints{end + 1} = t >= zeros(N,1);
constraints{end + 1} = t <= ones(N,1);
constraints{end + 1} = (w' * y - b)' .* z + 10000 * t  >= ones(N,1);
constraints{end + 1} = t' * ones(40,1) <= 40 * epsilon;
optimize([constraints{:}], obj, options);
w = double(w);
b = double(b);
for i = 1:40
    if z(i) == 1
        scatter(y(1,i), y(2, i), 'x', 'r');
        hold on
    else
        scatter(y(1,i), y(2, i), 'o', 'b');
        hold on
    end
end
x1 = -0.5:0.01:4;
x2 = (b - w(1) * x1)/w(2);
plot(x1,x2);
disp("jj");
end