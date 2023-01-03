function y = invgenfunc2(x,a,e)
% x is array of points to evaluate generalized function
% a is bump function width
% e is integral limit for evaluating value of function at point x

% Points over which to evaluate the integral
u = e:0.01*(x(2)-x(1)):x(length(x))+a;

% Points over which to evaluate the norm of the test function
v = x(1)-a:0.01*(x(2)-x(1)):x(length(x))+a;

% Function to evaluate
f = @(x) 1./x;
% Component to subtract out to make integral finite 
g = @(x) log(abs(x));

% Define testfunction at zero (this is the same whether we ank what
% is the value of x given a test function centered at zero or ask
% what is the value at zero of a test function centered at x).
%z = zeros(length(x));
for i=1:length(x)
    z(i)=testfunc(x(i),0,a); 
end

% Evaluate the function for all points x
%y = zeros(length(x));
for i=1:length(x)
    % infinite part of integral at point x
    inf = g(e)*z(i);
    % test function array centered at point x
    test = arrayfun(@(u) testfunc(x(i),u,a),u);
    % normalization of the test function
    norm = sum(arrayfun(@(v) testfunc(x(i),v,a),v));
    test = test./norm;
    func = arrayfun(@(u) invfunc(0,u),u);
    y(i) = dot(func,test)+inf;
end

plot(x,y,x,g(e)*z,x,f(x));