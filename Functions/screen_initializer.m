%% function help
% this function:
% 1) initializes the ptb screen for the experiment
% 2) displays the experiment opening text
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% ExpParams: structure containing experiment parameters

%%%%% Output %%%%%
% my_wPtr: windows pointer variable from "Screen OpenWindow"
% my_rect: screen dimensions variable from "Screen OpenWindow"
% my_cen_x: x location of screen center
% my_cen_y: y location of screen center

%% function
function [my_wPtr,my_rect,my_cen_x,my_cen_y] = screen_initializer(ExpParams)

% initialize the screen
Screen('Preference', 'SkipSyncTests', 1);
[my_wPtr,my_rect] = Screen('OpenWindow', ExpParams.screen_num, ExpParams.screen_color);
[my_cen_x my_cen_y] = RectCenter(my_rect);

% find and disable the default down keys
[~,~,DownKeys,~] = KbCheck();
DownKeys = find(DownKeys);
DisableKeysForKbCheck(DownKeys);

% starting text
DrawFormattedText(my_wPtr, ExpParams.start_text, 'center', my_rect(4)/2,0, ExpParams.text_color);
Screen('Flip',my_wPtr);
KbWait();

end

