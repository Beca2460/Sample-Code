%% BEN CAPELOTO - SAMPLE CODE FROM COURSE WORK 
% Description: This is sample code written by me from my undergrad courses.
%               This code compares Vortex Panel Method to Thin Airfoil 
%               Theory for different NACA Airfoils
%   Author:     Ben Capeloto
%   Collaborators: NONE
%   Created:    03/12/2021
%   Edited:     03/21/2022
%   Purpose:    Original          -   ASEN 3111 CA-03

%% House - Keeping
clear all; close all; clc;

%% Constants
c = 10;
N=100;
V_inf = 50;
alpha = linspace(-4,15, 100);
alpha_len = length(alpha);
%Thin airfoil theory
c_l_alpha = 2*pi*(alpha*pi/180);
dcda_alpha = mean(diff(c_l_alpha)/diff(alpha));

%% NACA 0012 varying angle of attack


%Define constants for NACA 0012
m_0012_0 = 0/100; 
p_0012_0 = 0/10;
t_0012_0 = 12/100;

c_l_0012 = zeros(1, alpha_len);
[x_0012_0, y_0012_0] = NACA_Airfoils(m_0012_0, p_0012_0, t_0012_0, c, N);
%100 Panels - Nominal amount
for i = 1:alpha_len
    [~, c_l_0012(i),~] = Vortex_Panel(x_0012_0,y_0012_0,V_inf,alpha(i));
end

%Plot NACA 0012
figure(1)
hold on; grid on;grid minor;
plot(alpha,c_l_0012);
plot(alpha,c_l_alpha);
xlim([-4 15]);
legend('c_{l} Vortex', 'c_{l} Thin Airfoil');
xlabel('AoA [deg]');
ylabel('c_{l}')
title('c_{l} vs. AoA: NACA 0012');

dcda_0012 = mean(diff(c_l_0012)/diff(alpha));
fprintf('Average lift slope for NACA 0012 is %f for Vortex \n\n', dcda_0012);
fprintf('Average lift slope for NACA 0012 is %f for Thin Airfoil \n\n', dcda_alpha);

%% NACA 2412 varying angle of attack

%Define constants for NACA 0012
m_2412_0 = 2/100; 
p_2412_0 = 4/10;
t_2412_0 = 12/100;

c_l_2412 = zeros(1, alpha_len);
[x_2412_0, y_2412_0] = NACA_Airfoils(m_2412_0, p_2412_0, t_0012_0, c, N);
%100 Panels - Nominal amount
for i = 1:alpha_len
    [~, c_l_2412(i),~] = Vortex_Panel(x_2412_0,y_2412_0,V_inf,alpha(i));
end

% Plot NACA 2412
figure(2)
hold on; grid on;grid minor;
plot(alpha,c_l_2412);
plot(alpha,c_l_alpha);
xlim([-4 15]);
legend('c_{l} Vortex', 'c_{l} Thin Airfoil');
xlabel('AoA [deg]');
ylabel('c_{l}')
title('c_{l} vs. AoA: NACA 2412');

dcda_2412 = mean(diff(c_l_2412)/diff(alpha));
fprintf('Average lift slope for NACA 2412 is %f for Vortex \n\n', dcda_2412);
fprintf('Average lift slope for NACA 2412 is %f for Thin Airfoil \n\n', dcda_alpha);
%% NACA 4412 varying angle of attack


%Define constants for NACA 0012
m_4412_0 = 4/100; 
p_4412_0 = 4/10;
t_4412_0 = 12/100;

c_l_4412 = zeros(1, alpha_len);
[x_4412_0, y_4412_0] = NACA_Airfoils(m_4412_0, p_4412_0, t_0012_0, c, N);
%100 Panels - Nominal amount
for i = 1:alpha_len
    [~, c_l_4412(i),~] = Vortex_Panel(x_4412_0,y_4412_0,V_inf,alpha(i));
end

% Plot NACA 4412
figure(3)
hold on; grid on;grid minor;
plot(alpha,c_l_4412);
plot(alpha,c_l_alpha);
xlim([-4 15]);
legend('c_{l} Vortex', 'c_{l} Thin Airfoil');
xlabel('AoA [deg]');
ylabel('c_{l}')
title('c_{l} vs. AoA: NACA 4412');

dcda_4412 = mean(diff(c_l_4412)/diff(alpha));
fprintf('Average lift slope for NACA 4412 is %f for Vortex \n\n', dcda_4412);
fprintf('Average lift slope for NACA 4412 is %f for Thin Airfoil \n\n', dcda_alpha);
%% NACA 2424 varying angle of attack


%Define constants for NACA 0012
m_2424_0 = 2/100; 
p_2424_0 = 4/10;
t_2424_0 = 24/100;

c_l_2424 = zeros(1, alpha_len);
[x_2424_0, y_2424_0] = NACA_Airfoils(m_2424_0, p_2424_0, t_0012_0, c, N);
%100 Panels - Nominal amount
for i = 1:alpha_len
    [~, c_l_2424(i),~] = Vortex_Panel(x_2424_0,y_2424_0,V_inf,alpha(i));
end

%Plot NACA 2424
figure(4)
hold on; grid on;grid minor;
plot(alpha,c_l_2424);
plot(alpha,c_l_alpha);
xlim([-4 15]);
legend('c_{l} Vortex', 'c_{l} Thin Airfoil');
xlabel('AoA [deg]');
ylabel('c_{l}')
title('c_{l} vs. AoA: NACA 2424');
dcda_2424 = mean(diff(c_l_2424)/diff(alpha));
fprintf('Average lift slope for NACA 2424 is %f for Vortex \n\n', dcda_2424);
fprintf('Average lift slope for NACA 2424 is %f for Thin Airfoil \n\n', dcda_alpha);