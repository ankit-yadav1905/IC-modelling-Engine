%% Problem Statement-1
clc

%% 1-->2: Adiabatic Process

P1 = 1;
T1 = 70+273;         % In Kelvin(K)
V1 = 1*0.0821*T1/P1; % PV = nRT =>V1 = nRT1/P1
T2 = 150+273;        % In Kelvin(K)
k = 2.5/1.5;         % k = Cp/Cv

T1_2 = linspace(T1,T2,1e5);
const1 = T1*(V1^(k-1)); % TV^(k-1)=constant => Adiabatic Process
V1_2=(const1./T1_2).^(1/(k-1)); % V2 = (T1V1^(k-1)/T2)^(1/(k-1))

const2=P1*V1^k;  % PV^k = constant => Adiabatic Process
P1_2=const2./(V1_2.^k);    % P2 = (P1V1^k)/(V2^k)

w1 = 1*8.314*(T2-T1)/(1-k);     % Work done in Adiabatic process = nRdT/(1-gamma)   
q1 = 0;     % Adiabatic Process => dq=0
u1 = -w1;   % from First Law of thermodynamics => Q=U+W and q=0 for adiabatic process =>u=-w
h1 = 2.5*8.314*(T2-T1); % h(enthalpy) = CpdT 
w1_area = trapz(V1_2,P1_2)*100;     % Area under curve gives answer in bar-L so we multiply with 100 to get the answer in Joules

%% 2-->3: Constant Pressure Process

P2 = P1_2(end);
P3 = P2;        % Isobaric Process
V2 = V1_2(end);

P2_3 = linspace(P2,P3,1e5);
T2_3 = linspace(T2,T1,1e5);
const3 = V2/T2;     % PV=nRT => V/T=constant (Constant pressure process)
V2_3 = const3.*T2_3;    % V3 = V2*T3/T2

T3 = T1;
q2 = 2.5*8.314*(T3-T2);     % For constant pressure process q = CpdT  
u2 = 1.5*8.314*(T3-T2);     % u(internal energy) = CpdT     (always valid)
w2 = q2-u2;   % from First Law of thermodynamics => Q=U+W =>w=q-u
h2 = 2.5*8.314*(T3-T2); % h(enthalpy) = CpdT 
w2_area = trapz(V2_3,P2_3)*100;      % Area under curve gives answer in bar-L so we multiply with 100 to get the answer in Joules

%% 3-->1: Isothermal Process

%T3 = T1;   % On line 35
V3 = V2_3(end);

T3_1 = linspace(T3,T1,1e5);
V3_1 = linspace(V3,V1,1e5);
const4 = P1*V1;       % PV=nRT => PV=constant (Isothermal Process)
P3_1 = const4./V3_1;  % P3 = P1V1/V3

u3 = 1.5*8.314*(T1-T3);     % u(internal energy) = CpdT =>Isothermal process so u=0
w3 = 1*8.314*T3*log(V1/V3);   % for isothermal process => W = nRTln(Vf/Vi)
q3 = w3;     % For isothermal process => u=0 =>q=u+w =>q=w  
h3 = 2.5*8.314*(T1-T3); % h(enthalpy) = CpdT =>Isothermal process so h=0
w3_area = trapz(V3_1,P3_1)*100;      % Area under curve gives answer in bar-L so we multiply with 100 to get the answer in Joules

%% For Whole Process

W = w1+w2+w3;
Q = q1+q2+q3;
U = u1+u2+u3;
H = h1+h2+h3;
W_area = w1_area+w2_area+w3_area;

%% Displaying Results

fprintf("Total Work Done = %.3f\n",W);
fprintf("Total Work calculated using P-V graph = %.3f\n",W_area);
fprintf("Total Heat = %.3f\n",Q);
fprintf("Total Internal Energy = %.3f\n",U);
fprintf("Total Enthalpy = %.3f\n",H);
fprintf("\n Work done calculated using thermodynamic formula and work using the P-V graph are approximately equal.\n");

%% For Irreversible Process

w1_irrev = 0.75*w1;     % Irreversible Work done for 1-->2 
q1_irrev = u1+w1_irrev;

w2_irrev = 0.75*w2;     % Irreversible Work done for 2-->3 
q2_irrev = u2+w2_irrev;

w3_irrev = 0.75*w3;     % Irreversible Work done for 3-->1 
q3_irrev = u3+w3_irrev;

% Overall Process
W_irrev = w1_irrev+w2_irrev+w3_irrev;
Q_irrev = q1_irrev+q2_irrev+q3_irrev;

% Displaying Results
fprintf("\nFor Irreversible Process:\n");
fprintf("Total Work Done = %.3f\n",W_irrev);
fprintf("Total Heat = %.3f\n",Q_irrev);
fprintf("\n We know that work decreases in irreversible proceesses.\n");


%% Plotting

% P-V Diagram
figure(1)
%subplot(1,3,1)
plot(V1_2,P1_2,DisplayName='Process:1=>2',LineWidth=1)
hold on
plot(V2_3,P2_3,DisplayName='Process:2=>3',LineWidth=1)
plot(V3_1,P3_1,DisplayName='Process:3=>1',LineWidth=1)
hold off
grid on
legend()
title("P-V Diagram")
xlabel("Volume (Litre)")
ylabel("Pressure (bar)")

% P-T Diagram
figure(2)
%subplot(1,3,2)
plot(T1_2,P1_2,DisplayName='Process:1=>2',LineWidth=1)
hold on
plot(T2_3,P2_3,DisplayName='Process:2=>3',LineWidth=1)
plot(T3_1,P3_1,DisplayName='Process:3=>1',LineWidth=1)
hold off
grid on
legend(Location='southeast')
title("P-T Diagram")
xlabel("Temperature (Kelvin)")
ylabel("Pressure (bar)")

% T-V Diagram
figure(3)
%subplot(1,3,3)
plot(V1_2,T1_2,DisplayName='Process:1=>2',LineWidth=1)
hold on
plot(V2_3,T2_3,DisplayName='Process:2=>3',LineWidth=1)
plot(V3_1,T3_1,DisplayName='Process:3=>1',LineWidth=1)
hold off
grid on
legend()
title("T-V Diagram")
xlabel("Volume (Litre)")
ylabel("Temperature (Kelvin)")