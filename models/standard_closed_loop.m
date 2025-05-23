% Controller params (Ecuación 15.13)
% Hc(s) = -42.673 * (0.82018*s + 1) / s
num_c = [-42.673 * 0.82018, -42.673];
den_c = [1, 0]; % from integrator
H_c = tf(num_c, den_c);
% Hc --> Eq 15.15    H_f --> Eq 15.15    
% e1 15.4 
% Calcula la FT de Lazo Abierto (Forward Path)
H_open_loop_combined = -H_c * H_f * H_e_HP;

% Closed loop FT
% feedback(G, H, sign) -> G / (1 - sign*G*H)
% G = H_open_loop_combined, H = 1, sign = -1 (negative feedback)
H_closed_loop = feedback(H_open_loop_combined, 1, -1);


figure;
step(H_closed_loop);
title('Closed Loop System Step Response (Demand n_{HP} to n_{HP})');
ylabel('Shaft Speed HP (%)');
xlabel('Time (s)');
grid on;