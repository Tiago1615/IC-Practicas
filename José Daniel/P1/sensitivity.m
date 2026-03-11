% Número de medidas
N = 1000;

% Preasignar el vector
medidas = zeros(1, N);

% Tomar las medidas
for i = 1:N
    medidas(i) = EAnalogIn(-1, 0, 0, 0);
end

% Cálculos
medidas_sorted = sort(medidas);

% Mostrar resultados
fprintf('Diff: %.10f\n', unique(sort(diff(medidas_sorted))));
