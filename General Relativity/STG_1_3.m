%% Look at ordering of space-like separated events
clear all
close all


A = spacetime_event("A", [0; 0; 0; 0], 'b');
B = spacetime_event("B", [100; 250; 0; 0], 'g');
C = spacetime_event("C", [350; 1000; 0; 0], 'r');

v_prime_boost = .5;

A_prime = A.boost_x1(v_prime_boost, "'");
B_prime = B.boost_x1(v_prime_boost, "'");
C_prime = C.boost_x1(v_prime_boost, "'");

v_prime2_boost = 0.8;
theta = acos(0.34 / v_prime2_boost);
A_prime2 = A.rotate_xy(theta, '').boost_x1(v_prime2_boost, "''");
B_prime2 = B.rotate_xy(theta, '').boost_x1(v_prime2_boost, "''");
C_prime2 = C.rotate_xy(theta, '').boost_x1(v_prime2_boost, "''");

[delta_s_1, delta_s_2, status] = invariance(C, C_prime);
disp([delta_s_1, delta_s_2, status]);

F = figure();
set(F, 'Units', 'normalize', 'Position', [0, 0.2, 0.6, 0.5]);
subplot(1, 3, 1)
spacetime_diagram([A, B, C], gca)
title('Rest Frame')

subplot(1, 3, 2)
spacetime_diagram([A_prime, B_prime, C_prime], gca)
title(['Boosted: v = ' num2str(v_prime_boost)]) 

subplot(1, 3, 3)
spacetime_diagram([A_prime2, B_prime2, C_prime2], gca)

title(['Rotated and Boosted: \theta = ' num2str(theta) ' v = ' num2str(v_prime2_boost)])

%% Calculations from notebook
t_a = 0;
x_a = 0;

t_b = 100;
x_b = 250;

t_c = 350;
x_c = 1000;

disp('(t_c - t_b) / (x_c - x_b):')
disp((t_c - t_b) / (x_c - x_b))

disp('(t_c) / (x_c):')
disp((t_c) / (x_c))





