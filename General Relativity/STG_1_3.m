%% Look at ordering of space-like separated events
clear all
close all


A = spacetime_event("A", 0, 0, 'b');
B = spacetime_event("B", 100, 200, 'g');
C = spacetime_event("C", 300, 500, 'r');

v_boost = 0.8;

A_prime = A.boost(v_boost, "'");
B_prime = B.boost(v_boost, "'");
C_prime = C.boost(v_boost, "'");

transpose_x_delta = -600;
A_prime2 = A.transpose(transpose_x_delta, 0, 0, "''");
B_prime2 = B.transpose(transpose_x_delta, 0, 0, "''");
C_prime2 = C.transpose(transpose_x_delta, 0, 0, "''");

F = figure();
set(F, 'Units', 'normalize', 'Position', [0, 0.2, 0.6, 0.5]);
subplot(1, 3, 1)
spacetime_diagram([A, B, C], gca)

subplot(1, 3, 2)
spacetime_diagram([A_prime, B_prime, C_prime], gca)

subplot(1, 3, 3)
spacetime_diagram([A_prime2, B_prime2, C_prime2], gca)




