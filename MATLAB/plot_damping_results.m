%% Plot Quarter-Car Damping Study Results

if ~exist('Results','var')
    Results = readtable('Damping_Study_Results.csv');
end

figure;
plot(Results.Damping_Ns_m, Results.RMS_Acceleration_m_s2, '-o', 'LineWidth',1.5,'MarkerSize',5);
xlabel('Damping Coefficient c_s (Ns/m)');
ylabel('RMS Sprung Acceleration (m/s^2)');
title('Effect of Damping on Ride Response');
grid on;

figure;
plot(Results.Damping_Ns_m, Results.Max_Suspension_Travel_m*1000, '-o', 'LineWidth',1.5,'MarkerSize',5);
xlabel('Damping Coefficient c_s (Ns/m)');
ylabel('Maximum Suspension Travel (mm)');
title('Effect of Damping on Suspension Travel');
grid on;

figure;
plot(Results.Damping_Ns_m, Results.Max_Tire_Deflection_m*1000, '-o', 'LineWidth',1.5,'MarkerSize',5);
xlabel('Damping Coefficient c_s (Ns/m)');
ylabel('Maximum Tire Deflection (mm)');
title('Effect of Damping on Tire Deflection');
grid on;
