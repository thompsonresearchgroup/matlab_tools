function y = gaussfunc(x,t,a)

y = 1/(sqrt(a*2*pi))*exp(-0.5*((t-x).^2)/a);

