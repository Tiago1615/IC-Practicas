clear; clc; close all;

%Leer dataset
filename = "CleanDataSensor.csv";
M = readmatrix(filename);
V_all = M(2:11,2:6);  
V_mean = mean(V_all, 1);
dist_cm = [10 20 30 40 50];

% Ajuste lineal para obtener el polinomio de grado 1
p1 = polyfit(V_mean, dist_cm, 1);  

% Distancias estimadas
dist_lin = polyval(p1, V_mean);

% Error absoluto, máximo absoluto y de escala
error_abs = dist_cm - dist_lin;
error_max = max(abs(error_abs));
error_scale = max(dist_cm) - min(dist_cm);

% Linealidad (%)
linealidad_total = (error_max / error_scale) * 100;

fprintf("Error máximo absoluto = %.4f cm\n", error_max);
fprintf("Linealidad = %.4f %% del fondo de escala\n", linealidad_total);