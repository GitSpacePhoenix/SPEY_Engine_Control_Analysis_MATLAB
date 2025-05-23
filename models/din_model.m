%% Implementing and Simulating Linear Dynamic Models
% Based on the Transfer Functions identified in the paper
% "Dynamic Model Identification of a Turbo Jet Engine" (Kulikov et al., 2004)
% Using parameters of the Table 15.5 y Eq 15.15.

clear; clc; close all;

%% 1. Definir los parámetros de las Funciones de Transferencia
% Parámetros del Motor (Table 15.5) - Valores para 80% n_HP
% Estructura: H(s) = K * (T1*s + 1) * exp(-tau*s) / ((T2*s + 1)*(T3*s + 1))

% Params n_HP (Table 15.5)
K_HP = 0.1174;      % Gain 
T1_HP = 0.4617;     % Time CTE. 
tau_HP = 0.0210;    % Delay

% Params n_LP (Table 15.5)
K_LP = 0.07667;     % Gain
T1_LP = 0.8598;     % Time CTE.
tau_LP = 0.0244;    % Delay

% Pole params (Table 15.5)
T2_den = 0.4524; 
T3_den = 1.7996; 

% Fuel source sys (Eq 15.15)
% Shape: Hf(s) = Kf * exp(-tau_f*s) / (Tf*s + 1)
K_f = 0.9876;       % Gain
T_f = 0.1058;       % Time CTE.
tau_f = 0.0898;     % Delay




% Num and den
num_HP = [K_HP*T1_HP, K_HP];
num_LP = [K_LP*T1_LP, K_LP];
num_f = [K_f]; % For Hf(s) as K / (Ts+1)

% Common den   jj: (T2*s + 1)*(T3*s + 1)
% (T2*s + 1)*(T3*s + 1) = T2*T3*s^2 + (T2+T3)*s + 1
den_motor = [T2_den*T3_den, T2_den+T3_den, 1];


den_f = [T_f, 1]; % Denominator for fuel supply model: (Tf*s + 1)

% Crear objetos TF incluyendo el retardo (InputDelay)
H_e_HP = tf(num_HP, den_motor, 'InputDelay', tau_HP); % TF del Motor a n_HP
H_e_LP = tf(num_LP, den_motor, 'InputDelay', tau_LP); % TF del Motor a n_LP
H_f = tf(num_f, den_f, 'InputDelay', tau_f);       % TF del Sistema de Alimentación de Combustible


%% 3. Step response and plots 

figure;
step(H_e_HP);
title('HP Axis Dynamic Model Step Response (H_{e\_HP})');
ylabel('Shaft Speed HP (%)');
xlabel('Time (s)');
grid on;

figure;
step(H_e_LP);
title('LP Axis Dynamic Model Step Response (H_{e\_LP})');
ylabel('Shaft Speed LP (%)');
xlabel('Time (s)');
grid on;

figure;
step(H_f);
title('Response to the Fuel System Dynamic Model Step Response (H_f)');
ylabel('Measured Fuel Flow (W_f)'); % La salida es Wf cuando la entrada es Wf_dem
xlabel('Time (s)');
grid on;


%% 4. Bode diagrams (Freq Response)

figure;
bode(H_e_HP);
title('Bode Diagram of the Dynamic Model of the HP Axis (H_{e_HP})');
grid on;

figure;
bode(H_e_LP);
title('Bode Diagram of the Dynamic Model of the LP Axis (H_{e_LP})');
grid on;

figure;
bode(H_f);
title('Bode Diagram of the Dynamic Model of the Fuel Feed System (H_f)');
grid on;


%% 5. Close loop simulations (Wf_dem a n_HP y n_LP)
% El sistema de lazo abierto completo es la serie de H_f y H_e
% H_open_loop(s) = H_f(s) * H_e(s)

H_open_loop_HP = H_f * H_e_HP; % Combinación en serie para Wf_dem -> n_HP
H_open_loop_LP = H_f * H_e_LP; % Combinación en serie para Wf_dem -> n_LP

% Simular respuesta al escalón del sistema de lazo abierto combinado
figure;
step(H_open_loop_HP);
title('Open Loop System Step Response (W_{fem} at n_{HP})');
ylabel('Shaft Speed HP (%)');
xlabel('Time (s)');
grid on;

figure;
step(H_open_loop_LP);
title('Open Loop System Step Response (W_{fem} to n_{LP})');
ylabel('LP Axis Speed (%)');
xlabel('Time (s)');
grid on;

% Simular Diagramas de Bode del sistema de lazo abierto combinado
figure;
bode(H_open_loop_HP);
title('Open Loop System Bode Diagram (W_{fem} to n_{HP})');
grid on;

figure;
bode(H_open_loop_LP);
title('Open Loop System Bode Diagram (W_{fem} to n_{LP})');
grid on;


%% Fin del script