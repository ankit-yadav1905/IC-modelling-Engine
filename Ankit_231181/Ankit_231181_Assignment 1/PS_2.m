%% Problem Statement-2
clc
%% For 1/(y_1+y_2)

%% Method-1: inetgrated wrt y_1

% y_2 = (y_1 - 1)/(0.1*y_1 + 0.9);
% After solving (y_1+y_2){everything in terms of y_1} 
% => (y_1^2+19*y_1-10)/(y_1+9)
% Thus we get our function as 1/(y_1+y_2) =>(y_1+9)/(y_1^2+19*y_1-10)

integrand = @(y_1) (y_1+9)./(y_1.^2 + 19*y_1 - 10);
soln_1_integral = integral(integrand,0,15); % Calculated using integral()

x = linspace(0,15,1e5);
Y = (x+9)./(x.^2 + 19*x - 10); % Replaced y_1 to x for simplicity.
soln_1_trapz = trapz(x,Y);  % Calculated using trapz()
%plot(x,Y)

%% Method-2 Integrated wrt X

% y_1 = 2*x+1
% y_2 = (2*x)/(1+0.2*x)
% After solving (y_1+y_2){everything in terms of x} 
% => (0.4*x^2+4.2*x+1)/(1+0.2*x)
% Thus we get our function as 1/(y_1+y_2) =>(1+0.2*x)/(0.4*x^2+4.2*x+1)
% And d(y_1) = 2*dx

func = @(X) (2+0.4*X)./(0.4.*X.*X+4.2*X+1);
soln_2_integral = integral(func,-0.5,7);   % Calculated using integral()

X1 = linspace(-0.5,7,1e5);
Y1 = (2+0.4*X1)./(0.4.*X1.*X1+4.2*X1+1); % Replaced X to X1 for simplicity.
soln_2_trapz = trapz(X1,Y1);    % Calculated using trapz()
%plot(X1,Y1)

%% Display Results

fprintf("M-1:Inetgration-1 using integral() fn = "+soln_1_integral+"\n")
fprintf("M-1:Inetgration-1 using trapz() fn = "+soln_1_trapz+"\n")
fprintf("M-2:Inetgration-1 using integral() fn = "+soln_2_integral+"\n")
fprintf("M-2:Inetgration-1 using trapz() fn = "+soln_2_trapz+"\n")

% Since I was getting 2 different answers hence I have mentioned both the
% results.

%% For 1/(y_1-y_2)

%% Method-1: inetgrated wrt y_1

% y_2 = (y_1 - 1)/(0.1*y_1 + 0.9);
% After solving (y_1-y_2){everything in terms of y_1} 
% => (y_1^2-y_1+10)/(y_1+9)
% Thus we get our function as 1/(y_1+y_2) =>(y_1+9)/(y_1^2-y_1+10)

integrand = @(y_1) (y_1+9)./(y_1.^2 - y_1 + 10);
soln_1_integral = integral(integrand,0,15); % Calculated using integral()

%% Display Results

fprintf("\nFor 1/(y_1-y_2):\n")
fprintf("Inetgration-2 using integral() fn = "+soln_1_integral+"\n")