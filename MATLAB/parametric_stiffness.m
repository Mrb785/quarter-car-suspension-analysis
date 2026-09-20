%% Quarter-Car Stiffness Parameter Study

clear;
clc;

model = "QuarterCar_Study";

ms = 290;
mu = 59;
cs = 750;
kt = 190000;

ks_values = 10000:1000:25000;

RMS_acc = zeros(size(ks_values));
max_suspension_travel = zeros(size(ks_values));
max_tire_deflection = zeros(size(ks_values));

load_system(model);

for i = 1:length(ks_values)
    ks = ks_values(i);
    fprintf('Running ks = %d N/m...\n', ks);

    assignin('base','ms',ms);
    assignin('base','mu',mu);
    assignin('base','cs',cs);
    assignin('base','kt',kt);
    assignin('base','ks',ks);

    simOut = sim(model);
    t = simOut.tout;
    acc_s = simOut.acc_s;
    suspension_travel = simOut.suspension_travel.Data;
    tire_deflection = simOut.tire_deflection.Data;

    RMS_acc(i) = sqrt(trapz(t,acc_s.^2) / (t(end)-t(1)));
    max_suspension_travel(i) = max(abs(suspension_travel));
    max_tire_deflection(i) = max(abs(tire_deflection));
end

Results = table(ks_values(:), RMS_acc(:), max_suspension_travel(:), max_tire_deflection(:), ...
    'VariableNames', {'Stiffness_N_m','RMS_Acceleration_m_s2','Max_Suspension_Travel_m','Max_Tire_Deflection_m'});

disp(Results);
writetable(Results,'Stiffness_Study_Results.csv');
save('Stiffness_Study_Results.mat','Results');

fprintf('\nStiffness study completed successfully.\n');
