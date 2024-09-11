%% function help
% this function displays the visual stimuli
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% ExpParams: structure containing experiment parameters
% my_wPtr: window pointer provided by PTB "Screen" function
% my_rect: screen sizes provided by PTB "Screen" function
% my_image_dir: "directory" and "name" of the visual stimulus

%%%%% Output %%%%%
% my_stim_onset_time: time of the stimulus display onset

%% function
function my_stim_onset_time = stimulus_presenter(ExpParams, my_wPtr, ...
    my_rect, my_image_dir, my_stim)

% load visual stimulus
my_current_vis_stim = imread(my_image_dir);
my_image_texture = Screen('MakeTexture', my_wPtr, my_current_vis_stim);

% create visual stimulus texture
my_image_rect = [0 0 ExpParams.image_width ExpParams.image_height];
% my_image_rect = [0 0 size(my_current_vis_stim,1) size(my_current_vis_stim,2)];
my_destination_rect = CenterRect(my_image_rect, my_rect);

% create bright circle for trigger
margin_distance = [4 2] .* ExpParams.trigger_circle_radius;
trigger_circle_loc(1) = my_rect(3) - margin_distance(1);
trigger_circle_loc(2) = my_rect(4) - margin_distance(1);
trigger_circle_loc(3) = my_rect(3) - margin_distance(2);
trigger_circle_loc(4) = my_rect(4) - margin_distance(2);

% presentation
if my_stim == 'stimulus'
    wait_time = ExpParams.vis_stim_time;
    Screen('FillOval', my_wPtr, ExpParams.trigger_circle_color, trigger_circle_loc);
    Screen('DrawTexture', my_wPtr, my_image_texture, [], my_destination_rect);
elseif my_stim == 'question'
    wait_time = 0;
    Screen('DrawTexture', my_wPtr, my_image_texture, [], my_destination_rect);
end

[~,my_stim_onset_time,~,~] = Screen('Flip',my_wPtr);
WaitSecs(wait_time);

end

