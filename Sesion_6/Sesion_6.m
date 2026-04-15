clear;
clc;
close all;

% Cargar datos de la señal normal
norm_data = readmatrix('SAMPLES_NORM.TXT');
t_norm = norm_data(:,1);   % tiempo en ms
v_norm = norm_data(:,2);   % voltaje en mV

% Representar señal normal
figure;
plot(t_norm, v_norm, 'b');
grid on;
xlabel('Tiempo [ms]');
ylabel('Voltaje [mV]');
title('SEÑAL DE RAMPA');

% Calcular amplitud de la señal normal
Vmax_norm = max(v_norm);
Vmin_norm = min(v_norm);
Vpp_norm = Vmax_norm - Vmin_norm;
A_norm = Vpp_norm / 2;
offset_norm = (Vmax_norm + Vmin_norm) / 2;

% Calcular noise ratio de la señal normal
v_norm_est = smoothdata(v_norm, 'movmean', 41);
noise_norm = v_norm - v_norm_est;
rms_noise_norm = rms(noise_norm);
rms_signal_norm = rms(v_norm_est);
noise_ratio_norm = rms_noise_norm / rms_signal_norm;

fprintf('--- SEÑAL DE RAMPA ---\n');
fprintf('Vmax = %.2f mV\n', Vmax_norm);
fprintf('Vmin = %.2f mV\n', Vmin_norm);
fprintf('Vpp = %.2f mV\n', Vpp_norm);
fprintf('Amplitud = %.2f mV\n', A_norm);
fprintf('Offset = %.2f mV\n', offset_norm);
fprintf('RMS del ruido = %.6f mV\n', rms_noise_norm);
fprintf('RMS de la señal estimada = %.6f mV\n', rms_signal_norm);
fprintf('Noise ratio = %.6f\n\n', noise_ratio_norm);

% Cargar datos de la señal senoidal
seno_data = readmatrix('SAMPLES_SENO.TXT');
t_seno = seno_data(:,1);   % tiempo en ms
v_seno = seno_data(:,2);   % voltaje en mV

% Representar señal senoidal
figure;
plot(t_seno, v_seno, 'r');
grid on;
xlabel('Tiempo [ms]');
ylabel('Voltaje [mV]');
title('SEÑAL SENOSOIDAL');

% Calcular amplitud de la señal senoidal
Vmax_seno = max(v_seno);
Vmin_seno = min(v_seno);
Vpp_seno = Vmax_seno - Vmin_seno;
A_seno = Vpp_seno / 2;
offset_seno = (Vmax_seno + Vmin_seno) / 2;

% Calcular noise ratio de la señal senoidal
v_seno_est = smoothdata(v_seno, 'movmean', 41);
noise_seno = v_seno - v_seno_est;
rms_noise_seno = rms(noise_seno);
rms_signal_seno = rms(v_seno_est);
noise_ratio_seno = rms_noise_seno / rms_signal_seno;

fprintf('--- SEÑAL SENOSOIDAL ---\n');
fprintf('Vmax = %.2f mV\n', Vmax_seno);
fprintf('Vmin = %.2f mV\n', Vmin_seno);
fprintf('Vpp = %.2f mV\n', Vpp_seno);
fprintf('Amplitud = %.2f mV\n', A_seno);
fprintf('Offset = %.2f mV\n', offset_seno);
fprintf('RMS del ruido = %.6f mV\n', rms_noise_seno);
fprintf('RMS de la señal estimada = %.6f mV\n', rms_signal_seno);
fprintf('Noise ratio = %.6f\n', noise_ratio_seno);