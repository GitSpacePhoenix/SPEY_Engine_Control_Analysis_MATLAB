% Ftom the next pnat
P_s = H_f*H_e_HP;

% Udding PID tuner
pidTuner(P_s)

% Gains Kp = 20.3, Ki = 12

%%

L_s = C*P_s;

FT_controller = feedback(L_s, 1, -1);
%step(FT_controller);

%title('Closed Loop System Step Response (New PID Controller)');
%ylabel('Velocidad del Eje HP (%)');
%xlabel('Tiempo (s)');
%grid on;

% Comparación de controladores

figure;

step(H_closed_loop, FT_controller);
title('Comparison of oridinal and PI controller');
legend('Original controller', 'New Pi Conroller');
ylabel('Velocidad del eje Hp (%)');
xlabel('Tiempo (s)');
grid on;