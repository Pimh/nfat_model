function ca = cal_calcium(t)

global period
global delta

S_high = 0.25;
S_rest = 0.05;

if (0 <= rem(t,period)) && (rem(t,period) <= delta)
    ca = S_high ;
else
    ca = S_rest;
end