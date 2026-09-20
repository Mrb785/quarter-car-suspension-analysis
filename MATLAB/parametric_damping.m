%% Quarter-Car Damping Parameter Study

clear;
clc;

model = "QuarterCar_Study";

ms = 290;
mu = 59;
ks = 16182;
kt = 190000;

cs_values = 500:250:5000;

RMS_acc = zeros(size(cs_values));
max_suspension_travel = zeros(size(cs_values));
max_tire_deflection = zeros(size(cs_values));

load_system(model);

for i = 1:length(cs_values)
    cs = cs_values(i);
    fprintf('Running cs = %d Ns/m...\n', cs);

    assignin('base','ms',ms);
    assignin('base','mu',mu);
    assignin('base','ks',ks);
    assignin('base','kt',kt);
    assignin('base','cs',cs);

    simOut = sim(model);
    t = simOut.tout;
    acc_s = simOut.acc_s;
    suspension_travel = simOut.suspension_travel.Data;
    tire_deflection = simOut.tire_deflection.Data;

    RMS_acc(i) = sqrt(trapz(t,acc_s.^2) / (t(end)-t(1)));
    max_suspension_travel(i) = max(abs(suspension_travel));
    max_tire_deflection(i) = max(abs(tire_deflection));
end

Results = table(cs_values(:), RMS_acc(:), max_suspension_travel(:), max_tire_deflection(:), ...
    'VariableNames', {'Damping_Ns_m','RMS_Acceleration_m_s2','Max_Suspension_Travel_m','Max_Tire_Deflection_m'});

disp(Results);
writetable(Results,'Damping_Study_Results.csv');
save('Damping_Study_Results.mat','Results');

fprintf('\nDamping study completed successfully.\n');
