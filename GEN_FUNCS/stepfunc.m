function y = stepfunc(x,t)

if t<x
    y = 0.0;
elseif t>x
    y = 1.0;
else
    y =0.5;
end

