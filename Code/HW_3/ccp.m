function [w,b]=ccp(epsilon)
yalmip clear
load('data.mat','y','z');
y = cell2mat(y);
options = sdpsettings('verbose', 0, 'dualize', 0, 'solver', 'mosek');
w = sdpvar(2,1);
b = sdpvar(1,1);
g = intvar(40,1);
obj = 0;
constraints = {};
constraints{end + 1} = w <= 100 * ones(2,1);
constraints{end + 1} = w >= -100 * ones(2,1);
constraints{end + 1} = b <= 100;
constraints{end + 1} = b >= -100;
constraints{end + 1} = g >= zeros(40,1);
constraints{end + 1} = g <= ones(40,1);
constraints{end + 1} = (w' * y - b)' .* z + 100000 * (1-g) >= ones(40,1);
constraints{end + 1} = g' * ones(40,1) >= 40 * (1-epsilon);
optimize([constraints{:}], obj, options);
w = double(w);
b = double(b);
figure(1);
hold on;
for i = 1:40
    if z(i) == 1
        scatter(y(1,i), y(2, i), 'x', 'r');
    else
        scatter(y(1,i), y(2, i), 'o', 'b');
    end
end
x1 = -0.5:0.01:4;
x2 = (b - w(1) * x1)/w(2);
plot(x1,x2);
hold off;
end