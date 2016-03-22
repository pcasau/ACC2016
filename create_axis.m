function handle = create_axis(x_data,y_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE_AXIS - accepts input data in a specified format and returns a
% handle for a matrix of axes
% INPUTS - x_data = [number of columns, bottom spacing, top spacing,
% inter-axis spacing]
%        - y_data = [number of rows, left spacing, right spacing, inter 
% axis spacing]
% OUTPUTS - handle - a matrix whose each entry (I,J) is a handle of the
% axes object at row I and column J
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nx = x_data(1);   %number of axes in x
    x0 = x_data(2); %bottom spacing
    x1 = x_data(3); %top spacing
    dx = x_data(4); %inter - axis spacing
    ny = y_data(1);   %number of axes in x
    y0 = y_data(2); %bottom spacing
    y1 = y_data(3); %top spacing
    dy = y_data(4); %inter - axis spacing
    h  = (1-y0-y1-(ny-1)*dy)/ny; %axis height
    w  = (1-x0-x1-(nx-1)*dx)/nx; %axis width
    handle = zeros(ny,nx);
    for I=1:ny
        for J=1:nx
            position = [x0+(J-1)*(w+dx);
                        y0+(ny-I)*(h+dy);
                        w;h];
            handle(I,J) = axes('Position',position);
        end
    end