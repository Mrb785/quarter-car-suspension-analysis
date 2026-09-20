%% Quarter-Car Combined Stiffness-Damping Study
% Combined parameter sweep of suspension stiffness and damping.
% Outputs RMS sprung acceleration, maximum suspension travel,
% maximum tire deflection, and maximum dynamic tire force.

clear;
clc;

model = "QuarterCar_Study";

ms = 290;
mu = 59;
kt = 190000;

ks_values = 10000:1000:25000;
cs_values = 500:250:5000;

n_ks = length(ks_values);
n_cs = length(cs_values);

fprintf('Total simulations = %d\n', n_ks*n_cs);

RMS_acc = zeros(n_ks,n_cs);
max_suspension_travel = zeros(n_ks,n_cs);
max_tire_deflection = zeros(n_ks,n_cs);
max_tire_force = zeros(n_ks,n_cs);

load_system(model);

for i = 1:n_ks
    ks = ks_values(i);
    for j = 1:n_cs
        cs = cs_values(j);
        fprintf('Running ks = %d N/m, cs = %d Ns/m...\n', ks,cs);

        assignin('base','ms',ms);
        assignin('base','mu',mu);
        assignin('base','ks',ks);
        assignin('base','cs',cs);
        assignin('base','kt',kt);

        simOut = sim(model);
        t = simOut.tout;
        acc_s = simOut.acc_s;
        suspension_travel = simOut.suspension_travel.Data;
        tire_deflection = simOut.tire_deflection.Data;
        tire_force = simOut.tire_force.Data;

        RMS_acc(i,j) = sqrt(trapz(t,acc_s.^2) / (t(end)-t(1)));
        max_suspension_travel(i,j) = max(abs(suspension_travel));
        max_tire_deflection(i,j) = max(abs(tire_deflection));
        max_tire_force(i,j) = max(abs(tire_force));
    end
end

[KS_grid,CS_grid] = ndgrid(ks_values,cs_values);

Results = table(KS_grid(:),CS_grid(:),RMS_acc(:),max_suspension_travel(:), ...
    max_tire_deflection(:),max_tire_force(:), ...
    'VariableNames', {'Stiffness_N_m','Damping_Ns_m','RMS_Acceleration_m_s2', ...
    'Max_Suspension_Travel_m','Max_Tire_Deflection_m','Max_Dynamic_Tire_Force_N'});

disp(Results);

writetable(Results,'Combined_ks_cs_Study_Results.csv');
save('Combined_ks_cs_Study_Results.mat','Results','ks_values','cs_values', ...
    'RMS_acc','max_suspension_travel','max_tire_deflection','max_tire_force');

fprintf('\n============================================\n');
fprintf('Combined stiffness-damping study completed.\n');
fprintf('Total simulations: %d\n',n_ks*n_cs);
fprintf('============================================\n');
