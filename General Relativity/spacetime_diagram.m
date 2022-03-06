function spacetime_diagram(events, ax_handle)
%SPACETIME_DIAGRAM plot a spacetime diagram with light cones in the array
%events 

for indx = 1:length(events)
    spacetime_event = events(indx);
    plot_light_cone(spacetime_event, ax_handle);
    hold on
end
grid on

xlim([-200, 1500])
ylim([-200, 400])
% Plot the axes
line([0,0], ylim, 'Color', 'k', 'LineWidth', 1); % Draw line for Y axis.
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 1); % Draw line for X axis.


    
end

