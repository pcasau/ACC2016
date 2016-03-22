function  out = sigma(v,gamma)
    out = gamma*sqrt(1-v.^2)+v*sqrt(1-gamma^2);