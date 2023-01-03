function y = testfunc(x,t,a)

if t<=x-1*a
    y = 0.0;
elseif t>=x+1*a
    y = 0.0;
else
    y = exp(-(a.^2)./(a.^2-(t-x).^2));
end
