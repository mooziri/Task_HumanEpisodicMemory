% In His Name
clc; clear; close all;
session_time(1) = GetSecs(); % save the start time of session
addpath(genpath('D:\Programming\Project_EEG_Memory'));

%% task information
% task for retrieval section
% task description goes here

%% initialize
% subject info
participant_num = subject_num();

% initialize experiment parameters
ExpParams = exp_parameters();

% turn off keyboard (protect experiment from mistaken key presses during the experiment)
ListenChar(-1);

%% task parameters
% separate old and new stimuli
counter_old = 1; counter_new = 1; counter_sim = 1;
for stim_i = 1 : size(ExpParams.StimSet_names,2)
    if contains(ExpParams.StimSet_names{stim_i},'old')
        stimuli_old{counter_old} = ExpParams.StimSet_names{stim_i};
        counter_old = counter_old + 1;
    elseif contains(ExpParams.StimSet_names{stim_i},'new')
        stimuli_new{counter_new} = ExpParams.StimSet_names{stim_i};
        counter_new = counter_new + 1;
    elseif contains(ExpParams.StimSet_names{stim_i},'sim')
        stimuli_sim{counter_sim} = ExpParams.StimSet_names{stim_i};
        counter_sim = counter_sim + 1;
    elseif contains(ExpParams.StimSet_names{stim_i},'resp')
        Question = ExpParams.StimSet_names{stim_i};
    end
end

% shuffle stimuli order
stimuli_old_shuff = shuffle(stimuli_old); % shuffle old stimuli
stimuli_new_shuff = shuffle(stimuli_new); % shuffle new stimuli
stimuli_sim_shuff = shuffle(stimuli_sim); % shuffle sim stimuli

StimSet_mixed = cat(2, stimuli_old_shuff, stimuli_new_shuff, stimuli_sim_shuff);
StimSet_shuff = shuffle(StimSet_mixed);

% initialize variables
participant_resp = nan(1,size(StimSet_shuff,2)); % vector of participant's responses to each stimulus
participant_resp_time = nan(1,size(StimSet_shuff,2)); % vector of participant's response times to each stimulus

%% the task
% initialize ptb
[wPtr,rect,cen_x,cen_y] = screen_initializer(ExpParams);

% display fixation cross
fixation_cross(ExpParams, wPtr, cen_x, cen_y);

% present visual stimuli and collect reponse
blank_time = ExpParams.min_isi_time_retrieval;
for stim_i = 1 : size(StimSet_shuff, 2)
    % create visual stimulus directory
    vis_stim_dir = strcat(ExpParams.StimSetDir, StimSet_shuff{stim_i});
    question_dir = strcat(ExpParams.StimSetDir, Question);
    
    % display fixation cross
    fixation_cross(ExpParams, wPtr, cen_x, cen_y);
    
    % display visual stimulus
    stim_onset_time(stim_i) = stimulus_presenter(ExpParams, wPtr, rect, vis_stim_dir, 'stimulus');
    
    % get participant's response
    tic;
    question_onset_time(stim_i) = stimulus_presenter(ExpParams, wPtr, rect, question_dir, 'question');
    [participant_resp(stim_i), participant_resp_time(stim_i)] = response_collector(ExpParams);
    reponse_time_method2(stim_i) = toc;
    
    % display trial number
    disp(strcat('Trial: #',num2str(stim_i)));
end

% finish and close the screen
sca;
session_time(2) = GetSecs(); % save the finish time of session

%% save data
% create data structure
session_data = struct('Participant_num', participant_num, ...
    'Session_type', 'retrieval', ...
    'Session_time', session_time, ...
    'Stim_onset', stim_onset_time, ...
    'Question_onset', question_onset_time, ...
    'Stim_order', {StimSet_shuff}, ...
    'Response', participant_resp, ...
    'Time_of_response', participant_resp_time, ...
    'Reponse_time', reponse_time_method2);

% save data
session_filename = strcat('Participant_', num2str(participant_num),'_retrieval.mat');
save(fullfile(ExpParams.SaveDataDir, session_filename), 'session_data');

%% compute participant's performace
% performance on old stimuli
ind_old = find(contains(StimSet_shuff, 'old'));
performace_old = (sum((participant_resp(ind_old) == ExpParams.tagOld)) ./ size(ind_old,2)) * 100;

% performance on new stimuli
ind_new = find(contains(StimSet_shuff, 'new'));
performace_new = (sum((participant_resp(ind_new) == ExpParams.tagNew)) ./ size(ind_new,2)) * 100;

% performance on similar stimuli
ind_sim = find(contains(StimSet_shuff, 'sim'));
performace_sim = (sum((participant_resp(ind_sim) == ExpParams.tagNew)) ./ size(ind_sim,2)) * 100;

% general performance
performance_total = ((performace_old * size(ind_old,2)) + ...
    (performace_new * size(ind_new,2)) + (performace_sim * size(ind_sim,2))) ./ ...
    size(StimSet_shuff,2);

%% disply info
clc;

% display session info
display_session_info(participant_num, ExpParams.SaveDataDir, ...
    performance_total, performace_old, performace_new, performace_sim);

% turn on keyboard again
ListenChar(0);






