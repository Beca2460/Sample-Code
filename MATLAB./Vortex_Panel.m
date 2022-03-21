function [X, c_l, C_p] = Vortex_Panel(x,y,V_inf,alpha)
%% ASEN 3111 - Computational Assignment 03 - Vortex_Panel
% Description: function takes arbitrary positions of a surface x, y
% and free stream Velocity and angle of attack. Returns sectional 
% coefficient of lift and coefficient of pressure 
% 
%%%%%%%%%% BASED OFF THE KUETHE & CHOW VORTEX PANEL METHOD %%%%%%%%%%%%%%%
%
%   Inputs:     x, y, V_inf, alpha
%   Outputs:    c_l, C_p, X
%
%   Author:     Ben Capeloto
%   Collaborators: NONE
%   Created:    03/12/2021
%   Edited:     03/20/2021
%   Purpose:    Original          -   ASEN 3111 CA-03

%% Organize input data

%Size = number of panels
M = length(x.Upper);
MP = M+1;
alpha = alpha*(pi/180); %alpha in radians
c = max(x.Upper); %cord length
%Organzie data to be trailing edge, bottom surface, leading edge, upper
%surface, trailing edge
XB = [flip(x.Lower) x.Upper];
YB = [flip(y.Lower) y.Upper];
XB = flip(XB);
YB = flip(YB);
YB(1,1) = 0;
YB(end, 1) = 0;

%% Dimensions 
X = zeros(1, M); Y = zeros(1, M); S = zeros(1, M); Sine = zeros(1, M); Cosine = zeros(1, M);
theta = zeros(1, M); V = zeros(1, M); CP = zeros(1, M); c_l = zeros(1,M); Gama = zeros(1, M);
RHS = zeros(1, M); CN1 = zeros(M); CN2 = zeros(M); CT1 = zeros(M); CT2 = zeros(M);
AN = zeros(M); AT = zeros(M, M+1);

%% Compute Control Points

for i = 1:M-1
    ip1 = i+1;
    X(i) = 0.5*(XB(i) + XB(ip1));
    Y(i) = 0.5*(YB(i) + YB(ip1));
    S(i) = sqrt((XB(ip1)-XB(i))^2 + (YB(ip1)-YB(i))^2);
    theta(i) = atan2((YB(ip1)-YB(i)), (XB(ip1)-XB(i)));
    Sine(i) = sin(theta(i));
    Cosine(i) = cos(theta(i));
    RHS(i) = sin(theta(i) - alpha);
end

%% Compute Coefficients 

%nested loop across entire airfoil
for i = 1:M-1
    for j = 1:M-1
        %if we are at an edge
        if (i==j)
            CN1(i,j) = -1.0;
            CN2(i,j) = 1.0;
            CT1(i,j) = 0.5*pi;
            CT2(i,j) = 0.5*pi;
        else
            A = - (X(i) - XB(j))*Cosine(j) - (Y(i) - YB(j))*Sine(j);
            B = (X(i) - XB(j))^2 + (Y(i) - YB(j))^2;
            C = sin(theta(i) - theta(j));
            D = cos(theta(i) - theta(j));
            E = (X(i) - XB(j))*Sine(j) - (Y(i) - YB(j))*Cosine(j);
            F = log(1.0 + S(j)*(S(j)+2.*A)/B);
            G = atan2((E*S(j)), (B + A*S(j)));
            P = ((X(i) - XB(j))*sin(theta(i) - 2*theta(j))) + ((Y(i) - YB(j))*cos(theta(i) - 2*theta(j)));
            Q = ((X(i) - XB(j))*cos(theta(i) - 2*theta(j))) - ((Y(i) - YB(j))*sin(theta(i) - 2*theta(j)));
            CN2(i,j) = D + (0.5*Q*F)/S(j) - (A*C + D*E)*(G/S(j));
            CN1(i,j) = 0.5*D*F + C*G - CN2(i,j);
            CT2(i,j) = C + (0.5*P*F)/S(j) + (A*D - C*E)*(G/S(j));
            CT1(i,j) = 0.5*C*F - D*G - CT2(i,j); 
        end
    end
    
%% Compute Influence Coeffcients
for i = 1:M-1
    AN(i,1) = CN1(i,1);
    AN(i,M) = CN2(1,M-1);
    AT(i,1) = CT1(i,1);
    AT(i,M) = CT2(i,M-1);
    for j = 2:M-1
        AN(i,j) = CN1(i,j) + CN2(i,j-1);
        AT(i,j) = CT1(i,j) + CT2(i,j-1);
    end
end
AN(M,1) = 1.0;
AN(M,M) = 1.0;
for j = 2:M-1
    AN(M,j) = 0.0;
end
RHS(M) = 0.0;

%% Solve System of Eqs
Gama = AN/RHS; %Eq 5.47 RHS*INV(AN)

%Calculate V at each control point and CP

for i = 1:M-1
    V(i) = cos(theta(i)-alpha); %5.49
    for j = 1:M
        V(i) = V(i) + AT(i,j)*Gama(j); %summation 5.49
        CP(i) = 1.0 - (V(i))^2; %5.50
    end
end

%Calculate sectional lift coefficient for Vortex method PDF
GAMMA = sum(V.*S);
c_l = (2*GAMMA)/(c); 
C_p = CP;
end