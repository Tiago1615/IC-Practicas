clear; 
clc;
close all;

% Leer archivo CSV
data = readmatrix('CleanDataSensor.csv');

% Quitar títulos
data = data(2:end,2:end);

% Calcular medias
V = mean(data);

% Distancias reales en cm
d = [10 20 30 40 50];

% Ajuste lineal
p1 = polyfit(d, V, 1);
V_lin = polyval(p1, d);

% Error cuadrático medio
MSE = mean((V - V_lin).^2);
RMSE = sqrt(MSE);

% Mostrar resultados
fprintf('Medias calculadas:\n');
disp(V)

fprintf('RMSE: %.6f V\n', RMSE);

% Gráfica
figure;
plot(d, V, 'o','LineWidth',2);
hold on;
plot(d, V_lin, '-','LineWidth',2);
grid on;
xlabel('Distancia (cm)');
ylabel('Voltaje (V)');
legend('Datos experimentales','Ajuste lineal');
title('Estimación de la linealidad del sensor');
