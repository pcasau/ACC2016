function out = VR(x,y,r,k)
    out = (1-r'*x)/(1-r'*x+k*(1-y'*x));
end