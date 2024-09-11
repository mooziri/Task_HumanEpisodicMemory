%% function help
% this function displays the post-stimulus blank screen
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% ExpParams: structure containing experiment parameters
% my_wPtr: window pointer provided by PTB "Screen" function
% my_blank_time: duration of the blank screen in sec
% my_cen_x: x location of screen center
% my_cen_y: y location of screen center

%%%%% Output %%%%%
% my_blank_onset_time: time of the blank onset

%% function
function my_blank_onset_time = blank_presenter(ExpParams, my_wPtr, my_blank_time, ...
    my_cen_x, my_cen_y)

fc_line = [my_cen_x-ExpParams.fc_length my_cen_x+ExpParams.fc_length my_cen_x my_cen_x;...
    my_cen_y my_cen_y my_cen_y-ExpParams.fc_length my_cen_y+ExpParams.fc_length];
Screen('DrawLines', my_wPtr, fc_line, ExpParams.fc_line_width, ExpParams.fc_color);

[~,my_blank_onset_time,~,~] = Screen('Flip',my_wPtr);
WaitSecs(my_blank_time);

end

