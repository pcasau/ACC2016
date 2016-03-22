function [R,dot_R,aux,dot_aux] = closerR(Rr,dot_Rr,v,dot_v,r)
    gm = S(Rr*r)*v;
    R = (eye(3)+S(gm)+(1+r'*Rr'*v)^(-1)*S(gm)^2)*Rr;
    aux = (S(gm)+(1+r'*Rr'*v)^(-1)*S(gm)^2)*Rr;
    if ~isempty(dot_Rr) && ~isempty(dot_v)
        %derivatives
        dot_gm = -S(v)*dot_Rr*r+S(Rr*r)*dot_v;
        dot_R = (S(dot_gm)-(v'*dot_Rr*r+r'*Rr'*dot_v)/(1+r'*Rr'*v)^2*S(gm)^2+(1+r'*Rr'*v)^(-1)*(dot_gm*gm'+gm*dot_gm'-2*dot_gm'*gm*eye(3)))*Rr+...
            (eye(3)+S(gm)+(1+r'*Rr'*v)^(-1)*S(gm)^2)*dot_Rr;
        dot_aux = (S(dot_gm)-(v'*dot_Rr*r+r'*Rr'*dot_v)/(1+r'*Rr'*v)^2*S(gm)^2+(1+r'*Rr'*v)^(-1)*(dot_gm*gm'+gm*dot_gm'-2*dot_gm'*gm*eye(3)))*Rr+...
            (S(gm)+(1+r'*Rr'*v)^(-1)*S(gm)^2)*dot_Rr;
    else
        dot_R = [];
        dot_gm = [];
        dot_aux= [];
    end
end