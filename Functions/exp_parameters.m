%% function help
% this function initializes the experiment parameters
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% none

%%%%% Output %%%%%
% exp_params: structure containing important parameters of the experiment

%% function
function exp_params = exp_parameters()

%% keyboard
KbName('UnifyKeyNames');
exp_params.keyboard_ind = 0;

% responses to stimuli
exp_params.respOld = KbName('RightArrow'); % keyboard response to indicate old stimuli
exp_params.respNew = KbName('LeftArrow'); % keyboard response to indicate new stimuli
exp_params.responses = [exp_params.respOld, exp_params.respNew];

% tag for each responses
exp_params.tagOld = 1; % tag indicating participant choosed "old"
exp_params.tagNew = 2; % tag indicating participant choosed "new"
exp_params.tagNoResp = nan; % tag indicating participant did not respond

%% timing
exp_params.vis_stim_time = 1; % duration of visual stimulus presentation
exp_params.min_isi_time_encode = 2; % minimum duration of inter-stimulus interval
exp_params.min_isi_time_retrieval = 0; % minimum duration of inter-stimulus interval
exp_params.fc_time = 2; % duration of fixation cross presentation at the start of the session
exp_params.max_resp_time = 2; % maximum amount of time for subject to respond in the retrieval session

%% screen
exp_params.screen_num = max(Screen('Screens')); % screen index
exp_params.screen_color = [165 165 165]; % screen background color

%% text
exp_params.start_text = 'Press any key to start'; % starting text
exp_params.text_color = [0 0 0]; % starting text color

%% fixation cross
exp_params.fc_length = 20; % fixation cross length
exp_params.fc_line_width = 7; % width of each fixation cross arm
exp_params.fc_color = [75 75 75]; % fixation cross color

%% stimulus presentation
exp_params.image_width = 600; % width of the visual stimulus
exp_params.image_height = 400; % height of the visual stimulus

%% circle to send trigger
exp_params.trigger_circle_color = [255 255 255]; % color of the circle
exp_params.trigger_circle_radius = 15; % radius of the circle

%% directories
% directory to stimulus set
exp_params.StimSetDir = 'D:\Programming\Project_EEG_Memory\StimulusSet\';

% directory to save the session data
exp_params.SaveDataDir = 'D:\Programming\Project_EEG_Memory\Data\';

%% get visual stimuli filenames
directory_files = dir(fullfile(exp_params.StimSetDir));
exp_params.StimSet_names = {directory_files(~[directory_files.isdir]).name};

end


