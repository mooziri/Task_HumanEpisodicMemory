%% function help
% this function collects the participant's response and response time
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% ExpParams: structure containing experiment parameters
% my_device_num: index of the keyboard that ptb should listen to

%%%%% Output %%%%%
% participant_resp: participant's resposne
% participant_resp_time: time of participant's resposne

%% function
function [my_participant_resp, my_participant_resp_time] = ...
    response_collector(ExpParams)

% initialize variables
responded = 0;
clear PsychHID; % force new enumeration of devices
clear KbCheck; % clear persistent cache of keyboard devices

% ask for response
tic;
while ~responded
    
    [key_pressed, key_time, keyCode] = KbCheck(ExpParams.keyboard_ind);
    the_key = find(keyCode,1);  % finds the pressed key
    
    if key_pressed && ismember(the_key, ExpParams.responses)
        
        % collect the response to the stimulus
        if ismember(the_key, ExpParams.respOld)
            my_participant_resp = ExpParams.tagOld; % response indicating old
            
        elseif ismember(the_key, ExpParams.respNew)
            my_participant_resp = ExpParams.tagNew; % response indicating old
            
        end
        
        % collect the response time to the stimulus
        my_participant_resp_time = key_time;
        
        % break the while loop
        responded = 1;
        key_pressed = 0;
        break
        
        % break the loop if the participant does not respond in maximum
        % allowed time
    elseif (~key_pressed) && (toc > ExpParams.max_resp_time)
        my_participant_resp = ExpParams.tagNoResp; % indicating participant did not respond
        my_participant_resp_time = ExpParams.tagNoResp;
        
        % break the while loop
        responded = 1;
        break
    end
end
end


