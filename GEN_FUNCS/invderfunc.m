function y = invderfunc(x,t)

if t<=x
    y = 0.0;
else
    y = 1./((t-x).^2);
end