% In His Name
clc; clear; close all;
session_time(1) = GetSecs(); % save the start time of session
addpath(genpath('D:\Programming\Project_EEG_Memory'));

%% task information
% task for encoding section
% task description goes here

%% initialize
% subject info
participant_num = subject_num();

% initialize experiment parameters
ExpParams = exp_parameters();

% turn off keyboard (protect experiment from mistaken key presses during the experiment)
ListenChar(-1);

%% task parameters
% select old stimuli only
counter_old = 1; counter_ask = 1;
for stim_i = 1 : size(ExpParams.StimSet_names,2)
    if contains(ExpParams.StimSet_names{stim_i},'old')
        stimuli_old{counter_old} = ExpParams.StimSet_names{stim_i};
        counter_old = counter_old + 1;
    elseif contains(ExpParams.StimSet_names{stim_i},'ask')
        questions{counter_ask} = ExpParams.StimSet_names{stim_i};
        counter_ask = counter_ask + 1;
    end
end

% shuffle stimuli order
StimSet_shuff = shuffle(stimuli_old);

% initialize variables
participant_resp = nan(1,size(StimSet_shuff,2)); % vector of participant's responses to each stimulus
participant_resp_time = nan(1,size(StimSet_shuff,2)); % vector of participant's response times to each stimulus

%% the task
% initialize ptb
[wPtr,rect,cen_x,cen_y] = screen_initializer(ExpParams);

% display fixation cross
fixation_cross(ExpParams, wPtr, cen_x, cen_y);

% visual stimuli presentation
for stim_i = 1 : size(StimSet_shuff, 2)
    % create directory to visual stimulus 
    vis_stim_dir = strcat(ExpParams.StimSetDir, StimSet_shuff{stim_i});
    
    % create directory to question
    ind_question = randperm(size(questions,2), 1);
    question_dir = strcat(ExpParams.StimSetDir, questions{ind_question});
    
    % display fixation cross
    fixation_cross(ExpParams, wPtr, cen_x, cen_y);
    
    % display visual stimulus
    stim_onset_time(stim_i) = stimulus_presenter(ExpParams, wPtr, rect, vis_stim_dir, 'stimulus');
    
    % post-stimulus quetion
    question_onset_time(stim_i) = stimulus_presenter(ExpParams, wPtr, rect, question_dir, 'question');
    [participant_resp(stim_i), participant_resp_time(stim_i)] = response_collector(ExpParams);
    
    % display trial number
    disp(strcat('Trial: #',num2str(stim_i)));
end

% finish and close the screen
sca;
session_time(2) = GetSecs(); % save the finish time of session

%% save data
% create data structure
session_data = struct('Participant_num', participant_num, ...
    'Session_type', 'encode', ...
    'Session_time', session_time, ...
    'Stim_onset', stim_onset_time, ...
    'Question_onset', question_onset_time, ...
    'Stim_order', {StimSet_shuff}, ...
    'Response', participant_resp, ...
    'Time_of_response', participant_resp_time);

% save data
session_filename = strcat('Participant_', num2str(participant_num),'_encode.mat');
save(fullfile(ExpParams.SaveDataDir, session_filename), 'session_data');

%% disply info
clc;
disp(['Subject:    ', num2str(participant_num)]);
disp(['Data saved at:    ', ExpParams.SaveDataDir]);
disp(['Filename:    ', session_filename]);

% turn on keyboard again
ListenChar(0);






