clear; clc; close all;
 
% Leer dataset
filename = "CleanDataSensor.csv";

M = readmatrix(filename);
V_all = M(2:11,2:6);  

dist_cm = [10 20 30 40 50];
V_mean = mean(V_all, 1);
grado = 3;

disp(V_mean);

% Ajuste del polinomio
p = polyfit(V_mean, dist_cm, grado);  

% Mse sobre los 5 puntos
dist_est = polyval(p, V_mean);
MSE = mean((dist_cm - dist_est).^2);

fprintf("Grado = %d\n", grado);
fprintf("MSE = %.6f (cm^2)\n", MSE);
disp("Coeficientes del polinomio d = f(V):");
disp(p);

% Grafica ajuste
Vfit = linspace(min(V_mean), max(V_mean), 200);
Dfit = polyval(p, Vfit);

figure;
plot(dist_cm, V_mean, 'o', 'LineWidth', 1.5); hold on;
plot(Dfit, Vfit, '-', 'LineWidth', 1.5);
grid on;
xlabel("Distancia (cm)");
ylabel("Voltaje (V)");
title(sprintf("Calibración polinomio grado %d (MSE=%.6f)", grado, MSE));
legend("Datos (media de barridos)", "Ajuste polinómico", "Location", "best");

