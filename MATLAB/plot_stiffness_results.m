%% Plot Quarter-Car Stiffness Study Results

if ~exist('Results','var')
    Results = readtable('Stiffness_Study_Results.csv');
end

figure;
plot(Results.Stiffness_N_m, Results.RMS_Acceleration_m_s2, '-o', 'LineWidth',1.5,'MarkerSize',5);
xlabel('Suspension Stiffness k_s (N/m)');
ylabel('RMS Sprung Acceleration (m/s^2)');
title('Effect of Suspension Stiffness on Ride Response');
grid on;

figure;
plot(Results.Stiffness_N_m, Results.Max_Suspension_Travel_m*1000, '-o', 'LineWidth',1.5,'MarkerSize',5);
xlabel('Suspension Stiffness k_s (N/m)');
ylabel('Maximum Suspension Travel (mm)');
title('Effect of Suspension Stiffness on Suspension Travel');
grid on;

figure;
plot(Results.Stiffness_N_m, Results.Max_Tire_Deflection_m*1000, '-o', 'LineWidth',1.5,'MarkerSize',5);
xlabel('Suspension Stiffness k_s (N/m)');
ylabel('Maximum Tire Deflection (mm)');
title('Effect of Suspension Stiffness on Tire Deflection');
grid on;
