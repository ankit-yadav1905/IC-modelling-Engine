clc

%% 1. Naive Problem
Ru = 0.008314;  % Universal gas Constant = Ru = 8.314 J/mol.K
Mol_wt = 0.0287; % (in kg/mol)
R = Ru/Mol_wt;      % R = Ru/Mol_wt (in kJ/kg.K) 
Cv = 0.718;
k = 1.4;        
r = 8;  % Compression ratio => r = vmax/vmin = V1/V2

% 1-->2: Adiabatic Compression Process
P1 = 100;
V1 = 0.0038;
T1 = 273+30;
m = P1*V1/(R*T1);   % mass of air => PV=mRT

V2 = V1/r;
const1 = P1*(V1^k);
P2 = const1/V2^k;
T2 = (P2*V2*T1)/(P1*V1);

V1_2 = linspace(V1,V2,1e4);
P1_2 = const1./(V1_2.^k);

w1_2 = (P2*V2-P1*V1)/(1-k);
q1_2 = 0;       % Adiabatic Process

% 2-->3: Constant Volume Process
V3 = V2;
T3 = 1200+273;
P3 = m*R*T3/V3;

w2_3 = 0;   % Constant Volume so, W=0;
u2_3 = m*Cv*(T3-T2);    % U = m*Cv*dT
q2_3 = u2_3;       % Q = U+W => W=0 =>Q = U

% 3-->4: Adiabatic Expansion Process
V4 = V1;
const2 = P3*(V3^k);
P4 = const2/(V4^k);
T4 = (P4*V4*T3)/(P3*V3); 
V3_4 = linspace(V3,V4,1e4);
P3_4 = const2./(V3_4.^k);

w3_4 = (P4*V4-P3*V3)/(1-k);
q3_4 = 0;       % Adiabatic Process

% 4-->1: Constant Volume Process

w4_1 = 0;   % Comstant Volume so, W=0;
u4_1 = m*Cv*(T1-T4);    % U = m*Cv*dT
q4_1 = u4_1;       % Q = U+W => W=0 =>Q = U

% Overall Process Calculation

W_net = w1_2 + w2_3 + w3_4 + w4_1;
Q_rej = q4_1;
Q_in = q2_3;
thermal_eff = W_net/Q_in*100;
% thermal_eff2 = 1-1/(r^(k-1));
MEP = W_net/(V1-V2);    % Mean Effective Pressure = Wnet/(Vmax-vmin) 

% Printing Results
fprintf('Heat Rejected (Q_out) = %.3f kJ\n',-Q_rej);
fprintf('Net work output (W_net) = %.3f kJ\n',W_net);
fprintf('Thermal efficiency of the cycle = %.1f%%\n',thermal_eff);
fprintf('Mean Effective Pressure (MEP) = %.3f kPa\n',MEP);


%% Ploting

figure(1)
plot(V1_2,P1_2, 'DisplayName','Isentropic compression','LineWidth',1);
hold on
plot([V2 V3],[P2 P3], 'DisplayName','Constant-volume heat addition', 'LineWidth',1);
plot(V3_4,P3_4, 'DisplayName','Isentropic expansion', 'LineWidth',1);
plot([V4 V1],[P4 P1], 'DisplayName','Constant-volume heat rejection', 'LineWidth',1);
title('P-V diagram for Otto Cycle')
legend()
xlabel('Volume (in m^3)');
ylabel('Pressure (in kPa)');
grid on
hold off
