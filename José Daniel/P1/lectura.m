clear; clc; close all;

% Polinomio obtenido previamente
p = [-13.9328  75.7394  -140.5081  106.4008];

% Leer dataset 
filename = "CleanDataSensor.csv";

M = readmatrix(filename);
V_all = M(2:11,2:6);   

%Convertir voltaje a distancia (cm) 
D_cm = polyval(p, V_all);


barridos = (1:10)';
T_cm = array2table(D_cm, 'VariableNames', ["10cm","20cm","30cm","40cm","50cm"]);
T_cm = addvars(T_cm, barridos, 'Before', 1, 'NewVariableNames', "Barrido");
disp("Tabla de distancias estimadas:");
disp(T_cm);