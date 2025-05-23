
%% 1. Define static models (Eq 15.9 y 15.10)
%  n = a + b * log(Wf + c)

%  n_HP Parameters
a_HP = -142.92;
b_HP = 39.27;
c_HP = 5.042;

%  n_LP Parameters
a_LP = -82.58;
b_LP = 22.64;
c_LP = -26.93;


Wf_range = linspace(30, 320, 200); % Comenzamos en 30 para cubrir el rango LP

% Filtrar Wf para asegurar que los argumentos del logaritmo sean positivos
valid_indices_HP = (Wf_range + c_HP) > 0;
valid_indices_LP = (Wf_range + c_LP) > 0;

% Usar solo los valores válidos para ambos modelos
valid_indices = valid_indices_HP & valid_indices_LP;
Wf_valid = Wf_range;

%% 3. Compute speeds from (n_HP, n_LP) statics models
n_HP_simulated = a_HP + b_HP * log(Wf_range + c_HP);
n_LP_simulated = a_LP + b_LP * log(Wf_range + c_LP);

%% 4. Compute statics gains from (K_HP, K_LP) derivates
% K = b / (Wf + c)

K_HP_simulated = b_HP ./ (Wf_range + c_HP);
K_LP_simulated = b_LP ./ (Wf_range + c_LP);

%% 5. Plot Static Relationships (Speed vs Fuel Flow)
figure;
plot(Wf_range, n_HP_simulated, 'b-', 'LineWidth', 1.5, 'DisplayName', 'n_{HP}');
hold on;
plot(Wf_range, n_LP_simulated, 'r-', 'LineWidth', 1.5, 'DisplayName', 'n_{LP}');
hold off;
xlabel('Fuel Flow, W_f (cc/s)');
ylabel('Shaft Speed (%), n');
title('Static Relationship: Shaft Speed vs Fuel Flow');
legend('Location', 'NorthWest');
grid on;

%% 6. Plot Static Gains (Gain vs Fuel Flow)
figure;
plot(Wf_valid, K_HP_simulated, 'b-', 'LineWidth', 1.5, 'DisplayName', 'K_{HP}');
hold on;
plot(Wf_valid, K_LP_simulated, 'r-', 'LineWidth', 1.5, 'DisplayName', 'K_{LP}');
hold off;
axis([100 Wf_range(end) 0 0.3]); % Keep the axis limits for better comparison with paper figures if needed
xlabel('Fuel Flow, W_f (cc/s)');
ylabel('Static Gain (%/(cc/s))');
title('Static Gain vs Fuel Flow');
legend('Location', 'NorthEast');
grid on;