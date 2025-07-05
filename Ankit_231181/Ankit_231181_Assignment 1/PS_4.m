%% Problem statement-4
clc
% Since its a hyperbolic curve so we take 2 same functions with different 
% intervals separating at the asymptote of the hyperbola, at x=-1.
x1 = linspace(-3.4142,-1.01,1e4);
y1 = 2*x1./(1+x1);
x2 = linspace(-0.99,2.4142,1e4);
y2 = 2*x2./(1+x2);

func = @(X) [(2*X(1))/(1+X(1))-X(2);
             2/((1+X(1))^2)-(X(2)-1)/X(1)];
ini_guess1 = [-0.5;-1];  
intersection_pt1 = fsolve(func,ini_guess1);
ini_guess2 = [2.4;1];
intersection_pt2 = fsolve(func,ini_guess2);

% Intersection Point:1
Xt1 = intersection_pt1(1);
Yt1 = intersection_pt1(2);
fprintf("Intersection Point-1: (Xt,Yt) = ("+Xt1+","+Yt1+")\n\n");
% Intersection Point:2
Xt2 = intersection_pt2(1);
Yt2 = intersection_pt2(2);
fprintf("Intersection Point-2: (Xt,Yt) = ("+Xt2+","+Yt2+")\n");

% Figure Plotting
figure()
plot(x1,y1,x2,y2,'DisplayName','Function','LineWidth',1) %Graph of function
hold on
plot([0 Xt1],[1 Yt1],'-o','DisplayName','Tangent1','LineWidth',1) %Tangent-1
plot([0 Xt2],[1 Yt2],'-o','DisplayName','Tangent2','LineWidth',1) %Tangent-2
legend()
title('Tangent along with y')
xlabel('x')
ylabel('y')
grid on
hold off
