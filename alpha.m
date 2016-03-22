function out = alpha(v,gamma)
    out = gamma*v-sqrt((1-v.^2)*(1-gamma^2));