clear all
close all

v = [0:0.001:0.999];
gamma = (1 - v.^2) .^ (-1/2);
u_mag = 0.5;

theta_prime_i = 5*pi/8;

disp(cos(theta_prime_i))
disp(sin(theta_prime_i))

%% Angle Calculations

theta_prime_r = atan2(-cos(theta_prime_i), -sin(theta_prime_i));

u_prime_x = u_mag * cos(theta_prime_i);
u_prime_y = u_mag * sin(theta_prime_i);

theta_i = atan2((gamma .* (u_prime_y + abs(v))), u_prime_x);
theta_i = smart_atan(theta_i);

figure()
plot(v, theta_i)
hold on
title(['Incident Angle: ' num2str(theta_prime_i)])
set(gca,'YTick',0:pi/4:2*pi) 
set(gca,'YTickLabel',{'0','\pi/4','\pi/2','3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
ylim([0,2*pi])
hold off

theta_r = atan2(-(gamma .* (u_prime_x - abs(v))), -u_prime_y);
theta_r = smart_atan(theta_r);

figure()
plot(v, theta_r)
hold on
title(['Reflected Angle: ' num2str(theta_prime_r)])
set(gca,'YTick',0:pi/4:2*pi) 
set(gca,'YTickLabel',{'0','\pi/4','\pi/2','3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
ylim([0,2*pi])
hold off

%% Plot both angles together
figure()
plot(v, theta_i, 'b')
hold on
plot(v, theta_r, 'r')
legend('Incident Angle', 'Reflected Angle')
set(gca,'YTick',0:pi/4:2*pi) 
set(gca,'YTickLabel',{'0','\pi/4','\pi/2','3\pi/4', '\pi', '5\pi/4', '3\pi/2', '7\pi/4', '2\pi'})
ylim([0,2*pi])
hold off


%% Velocity Calculations

u_y = (u_prime_y + v) ./ (1 + v .* u_prime_y);
u_x = u_prime_x ./ (gamma .* (1 + v .* u_prime_y));
u_tot = (u_y .^ 2 + u_x .^ 2) .^ (1/2);

r_y = (-u_prime_x + v) ./ (1 - v .* u_prime_x);
r_x = -u_prime_y ./ (gamma .* (1 - v .* u_prime_x));
r_tot = (r_y .^ 2 + r_x .^ 2) .^ (1/2);

figure() 
subplot(2, 3, 1)
plot(v, u_x)
title('u_x vs. v')

subplot(2, 3, 2)
plot(v, u_y)
title('u_y vs. v')

subplot(2, 3, 3)
plot(v, u_tot);
title('u_{tot} vs. v')

subplot(2, 3, 4)
plot(v, r_x)
title('r_x vs. v')

subplot(2, 3, 5)
plot(v, r_y)
title('r_y vs. v')

subplot(2, 3, 6)
plot(v, r_tot);
title('r_{tot} vs. v')
