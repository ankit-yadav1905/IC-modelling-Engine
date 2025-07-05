clc

%% 2. Otto Cycle Simulation & Code Implementation

%% Without considering piston kinematics

gamma = 1.35;
CR = 8.5;
bore = 0.09;
stroke = 0.1;
con_rod = 0.14;

V_swept = 3.14*(bore^2)*stroke/4;
V_clearance = V_swept/(CR-1);

P1 = 110;
T1 = 400;
V1 = V_clearance + V_swept;

V2 = V_clearance;
P2 = P1*(V1/V2)^gamma;
T2 = (P2*V2*T1)/(P1*V1);

V3 = V2;
T3 = 2800;
P3 = P2*T3/T2;

V4 = V1;
P4 = P3*(V3/V4)^gamma;
T4 = (P4*V4*T1)/(P1*V1);

fprintf("At State 1: Volume = %f m^3, Pressure = %.3f kPa, Temperature = %.3f K\n",V1,P1,T1);
fprintf("At State 2: Volume = %f m^3, Pressure = %.3f kPa, Temperature = %.3f K\n",V2,P2,T2);
fprintf("At State 3: Volume = %f m^3, Pressure = %.3f kPa, Temperature = %.3f K\n",V3,P3,T3);
fprintf("At State 4: Volume = %f m^3, Pressure = %.3f kPa, Temperature = %.3f K\n",V4,P4,T4);

thermal_eff = (1-(1/(CR^(gamma-1))))*100;
fprintf("\nThermal efficiency of the otto cycle = %.4f\n",thermal_eff);

% Plotting
figure(1)
plot([V1 V2],[P1 P2],'DisplayName','Isentropic compression','LineWidth',1.2);
hold on
plot([V2 V3],[P2 P3],'DisplayName', 'Constant-volume heat addition', 'LineWidth',1.2);
plot([V3 V4],[P3 P4],'DisplayName', 'Isentropic expansion', 'LineWidth',1.2);
plot([V4 V1],[P4 P1], 'DisplayName','Constant-volume heat rejection', 'LineWidth',1.2);
title("Basic P-V Diagram for Otto Cycle");
legend()
xlabel("Volume (in m^3)");
ylabel("Pressure (in kPa)");
grid on
hold off

%% With considering piston kinematics

V_comp = piston_kinematics(bore,stroke,con_rod,CR,180,0);
const1 = P1*V1^gamma;
P_comp = const1./(V_comp.^gamma);

V_exp = piston_kinematics(bore,stroke,con_rod,CR,180,360);
const2 = P3*V3^gamma;
P_exp = const2./(V_exp.^gamma);

% Plotting
figure(2)
plot(V_comp,P_comp,'DisplayName','Isentropic compression','LineWidth',1.2);
hold on
plot([V2 V3],[P2 P3],'DisplayName', 'Constant-volume heat addition', 'LineWidth',1.2);
plot(V_exp,P_exp,'DisplayName', 'Isentropic expansion', 'LineWidth',1.2);
plot([V4 V1],[P4 P1], 'DisplayName','Constant-volume heat rejection', 'LineWidth',1.2);
title("Final P-V Diagram for Otto Cycle");
legend()
xlabel("Volume (in m^3)");
ylabel("Pressure (in kPa)");
grid on
hold off

fprintf("\n=>Inferences comparing the P-V diagrams with and without considering piston kinematics.\n");

fprintf("\n-->The P-V diagram without considering piston kinematics assumes idealized,\n" + ...
    "smooth transitions, leading to simplified pressure and volume relationships. \n" + ...
    "When piston kinematics are included, the diagram reflects real-world dynamics, \n" + ...
    "such as non-uniform piston motion and pressure fluctuations, resulting in a more \n" + ...
    "accurate depiction of the thermodynamic cycle.\n");

%% Task 2 :  analyze the impact of changing compression ratios on the thermal efficiency. 

c_r = linspace(1,12,20000);
c_ratio = [7 9 11];
ther_eff = (1-1./(c_r.^(gamma-1)))*100;
t_eff = (1-1./(c_ratio.^(gamma-1)))*100;

% Plotting
figure(3)
plot(c_r,ther_eff,'DisplayName','Compressibility Ratios','LineWidth',1.2);
hold on
plot(c_ratio,t_eff,'o','DisplayName','CR= 7,9,11','LineWidth',1);
title('Thermal Efficiency v/s Compressibility Ratio')
legend('Location','northwest')
xlabel('Compressibility Ratios');
ylabel('Thermal Efficiency (%)');
grid on
hold off

fprintf("\n=>Analyzing the impact of changing compression ratios on the thermal efficiency.\n");
fprintf("\n-->Thermal efficiency increases with higher compression ratios, \n"+ ...
    "as seen for CR = 7, 9, and 11, but with diminishing returns. \n" +...
    "This highlights the benefits of higher ratios while balancing engine constraints.\n");

%% Function for Piston Kinematics

function [V] = piston_kinematics(bore,stroke,con_rod,cr,start_crank,end_crank)
    a = stroke/2;
    R = con_rod/a;
    V_s = 3.14*bore^2*stroke/4;
    V_c = V_s/(cr-1);

    angle = linspace(start_crank,end_crank,100);

    term1 = 0.5*(cr-1);
    term2 = R+1-cosd(angle);
    term3 = (R^2-sind(angle).^2).^0.5;

    V = (1 + term1 * (term2-term3)).*V_c;
end