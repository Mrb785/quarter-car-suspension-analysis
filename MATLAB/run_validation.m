%% Quarter-Car Model - Validation
% Validates the passive 2-DOF quarter-car model against
% published multiple-bump simulation results.

clear;
clc;

%% Model Parameters
ms = 290;
mu = 59;
ks = 16182;
cs = 1000;
kt = 190000;

%% Simulation
simTime = 7;
out = sim('QuarterCar_Validation', 'StopTime', num2str(simTime));

%% Extract Logged Signals
t = out.tout;
acc_s = out.acc_s;
zs = out.sprung_displacement.Data;
zu = out.unsprung_displacement.Data;

%% Calculate Peak Responses
max_sprung_displacement = max(abs(zs));
max_sprung_acceleration = max(abs(acc_s));
max_unsprung_displacement = max(abs(zu));

%% Published Reference Values
paper_sprung_displacement = 0.068;
paper_sprung_acceleration = 8.0;
paper_unsprung_displacement = 0.120;

%% Percentage Differences
error_sprung_displacement = abs(max_sprung_displacement - paper_sprung_displacement) / paper_sprung_displacement * 100;
error_sprung_acceleration = abs(max_sprung_acceleration - paper_sprung_acceleration) / paper_sprung_acceleration * 100;
error_unsprung_displacement = abs(max_unsprung_displacement - paper_unsprung_displacement) / paper_unsprung_displacement * 100;

fprintf('\n===== QUARTER-CAR VALIDATION =====\n');
fprintf('Maximum sprung displacement   : %.4f m\n', max_sprung_displacement);
fprintf('Reference sprung displacement : %.4f m\n', paper_sprung_displacement);
fprintf('Deviation                     : %.2f %%\n\n', error_sprung_displacement);
fprintf('Maximum sprung acceleration   : %.4f m/s^2\n', max_sprung_acceleration);
fprintf('Reference sprung acceleration : %.4f m/s^2\n', paper_sprung_acceleration);
fprintf('Deviation                     : %.2f %%\n\n', error_sprung_acceleration);
fprintf('Maximum unsprung displacement : %.4f m\n', max_unsprung_displacement);
fprintf('Reference unsprung displacement : %.4f m\n', paper_unsprung_displacement);
fprintf('Deviation                     : %.2f %%\n', error_unsprung_displacement);

Metric = {'Maximum Sprung Displacement'; 'Maximum Sprung Acceleration'; 'Maximum Unsprung Displacement'};
Simulation = [max_sprung_displacement; max_sprung_acceleration; max_unsprung_displacement];
Published = [paper_sprung_displacement; paper_sprung_acceleration; paper_unsprung_displacement];
Percentage_Difference = [error_sprung_displacement; error_sprung_acceleration; error_unsprung_displacement];

Validation_Comparison = table(Metric, Simulation, Published, Percentage_Difference);

if ~exist('Results/Validation', 'dir')
    mkdir('Results/Validation');
end

writetable(Validation_Comparison, 'Results/Validation/Validation_Comparison.csv');

figure('Position',[100 100 900 700]);
subplot(3,1,1);
plot(t,zs,'LineWidth',1.5); grid on;
xlabel('Time (s)'); ylabel('z_s (m)');
title('Sprung-Mass Displacement');

subplot(3,1,2);
plot(t,acc_s,'LineWidth',1.5); grid on;
xlabel('Time (s)'); ylabel('Acceleration (m/s^2)');
title('Sprung-Mass Acceleration');

subplot(3,1,3);
plot(t,zu,'LineWidth',1.5); grid on;
xlabel('Time (s)'); ylabel('z_u (m)');
title('Unsprung-Mass Displacement');

sgtitle('Quarter-Car Model Validation');
exportgraphics(gcf, 'Results/Validation/Validation_Response.png', 'Resolution',300);

fprintf('\nValidation files saved successfully.\n');
