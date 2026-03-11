% Número de medidas
N = 100;

% Preasignar el vector
medidas = zeros(1, N);

% Tomar las medidas
for i = 1:N
    medidas(i) = EAnalogIn(-1, 0, 0, 0);
end

% Cálculos
media_medidas = mean(medidas);
desviacion_medidas = std(medidas);

% Mostrar resultados
fprintf('Media: %.4f | Desviación: %.4f\n', media_medidas, desviacion_medidas);
