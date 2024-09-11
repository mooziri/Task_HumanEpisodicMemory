%% function help
% this function displays the fixation cross at the center of the screen
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% ExpParams: structure containing experiment parameters
% my_wPtr: windows pointer variable from "Screen OpenWindow"
% my_cen_x: x location of screen center
% my_cen_y: y location of screen center

%%%%% Output %%%%%
% none

%% function
function fixation_cross(ExpParams, my_wPtr, my_cen_x, my_cen_y)

% fixation cross sizes
fc_line = [my_cen_x-ExpParams.fc_length my_cen_x+ExpParams.fc_length my_cen_x my_cen_x;...
    my_cen_y my_cen_y my_cen_y-ExpParams.fc_length my_cen_y+ExpParams.fc_length];

Screen('DrawLines', my_wPtr, fc_line, ExpParams.fc_line_width, ExpParams.fc_color);
Screen('Flip',my_wPtr);
WaitSecs(ExpParams.fc_time);

end

