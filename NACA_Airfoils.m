function [x,y] = NACA_Airfoils(m,p,t,c,N)
%% ASEN 3111 - Computational Assignment 03 - NACA_Airfoils
% Description: function takes NACA airfoil data m, n, p, t, c, N
% and converts it into x, y [vectors] cartersian coordinates
% 
%
%   Inputs:     m, p, t, c, N
%   Outputs:    x, y
%
%   Author:     Ben Capeloto
%   Collaborators: NONE
%   Created:    03/12/2021
%   Edited:     03/20/2021
%   Purpose:    Original          -   ASEN 3111 CA-03

%% Code

%define x position along cord
dx = linspace(0, c, N);

%pre-allocate y_t and y_c
y_t = zeros(1, c);
y_c = zeros(1, c);

%Loop through the points along the cord
for i = 1:N
    %calculate y_t
    y_t(i) = (c*t/0.2)*(0.2969*sqrt(dx(i)/c)-0.1260*sqrt(dx(i)/c)-0.3516*((dx(i)/c)^2)+0.2843*((dx(i)/c)^3)-0.1036*((dx(i)/c)^4));
    %if the position on the cord is in front of the maximum camber point
    if dx(i) < p*c
        %calculate y_c
        y_c(i) =  m*(dx(i)/(p^2))*(2*p-(dx(i)/c));
    %if the position on the cord is behind of the maximum camber point   
    elseif dx(i) > p*c
        %calculate y_c
        y_c(i) =  m*((c-dx(i))/(1-p)^2)*(1+dx(i)/c-2*p);
    end
end

%calculate zeta
zeta = atan(diff(y_c)./diff(dx));
%set the first value of zeta equal to zero
zeta = [0 zeta];

%calculate x and y positions for upper and lower surfaces
x_U = dx-y_t.*sin(zeta);
x_L = dx+y_t.*sin(zeta);
y_U = y_c+y_t.*cos(zeta);
y_L = y_c-y_t.*cos(zeta);

%make the x and y coordinate structs for returning
x = struct('Upper', x_U, 'Lower', x_L);
y = struct('Upper', y_U, 'Lower', y_L);

end