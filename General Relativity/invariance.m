function [delta_s_1, delta_s_2, status] = invariance(event_frame_1, event_frame_2)
%INVARIANCE Check that a space time event in two reference frames is
%invariat 
delta_s_1 = sqrt(event_frame_1.x(1)^2 - (event_frame_1.x(2)^2 + event_frame_1.x(3)^2 + event_frame_1.x(4)^2));
delta_s_2 = sqrt(event_frame_2.x(1)^2 - (event_frame_2.x(2)^2 + event_frame_2.x(3)^2 + event_frame_2.x(4)^2));

delta_diff_pct = 100 * (delta_s_1 - delta_s_2)/delta_s_1;
if delta_diff_pct < 0.0001
    status = true;
else
    status = false;
end

