%% Problem Statement - 3
clc
func = @(X) [X(1)^2 + X(2)^2 - 4;
             X(1)^2 - X(2) - 1];

% There will be 2 intersection points of the circle and the parabola as solved in the notebook.
% Solution-1
ini_guess = [2,2];
solution_1 = fsolve(func,ini_guess);
% Solution-2
ini_guess = [-2,2];
solution_2 = fsolve(func,ini_guess);

% Print
disp("Intersection Points:");
disp("1. ("+solution_1(1)+","+solution_1(2)+")");
disp("2. ("+solution_2(1)+","+solution_2(2)+")")