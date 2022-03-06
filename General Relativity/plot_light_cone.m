function plot_light_cone(spacetime_event, ax_handle)
%PLOT_LIGHT_CONE plot a light cone on a spacetime diagram from a spacetime
%event

%% Figure out the null lines
t_0 = spacetime_event.x(1);
x_0 = spacetime_event.x(2);

t_right = [t_0-1000:1:t_0+1000];
t_left = [t_0+1000:-1:t_0-1000];
x = [x_0-1000:1:x_0+1000];

line(x, t_right, 'Color', spacetime_event.color)
line(x, t_left, 'Color', spacetime_event.color)
text(x_0, t_0, spacetime_event.name, 'Color', spacetime_event.color)

end

