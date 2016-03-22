function out = gradVR(x,y,r,k)
    out = (k*VR(x,y,r,k)*y-(1-VR(x,y,r,k))*r)/(1-r'*x+k*(1-y'*x));
end