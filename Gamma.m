function out = Gamma(A)
    out = -[S(A*[1;0;0]),S(A*[0;1;0]),S(A*[0;0;1])]';