%% function help
% this function displays the session info
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% my_participant_num: subject number
% my_save_data_dir: directory of saved session data
% my_performance_total: participant's general performance
% my_performace_old: participant's performance on old stimuli
% my_performace_new: participant's performance on new stimuli

%%%%% Output %%%%%
% none

%% function
function display_session_info(my_participant_num, my_save_data_dir, ...
    my_performance_total, my_performace_old, my_performace_new, my_performace_sim)

figure('Name', 'Session Info', 'Position', [150 150 800 400], 'Color', 'w');
patch([10 90 90 10],[20 20 90 90],[1 1 1],'LineStyle','none','FaceAlpha',1);
set(gca, 'visible', 'off');
hold on;

% display session file info
patch([10 90 90 10],[65 65 90 90],[.8 .8 .8],'LineWidth',1,'FaceAlpha',.3);
text(15,85,['Session File Info'],'fontsize',14,'fontweight','bold','Color','k');
text(15,75,['Subject:    ', num2str(my_participant_num)],'fontsize',12,'fontweight','bold','Color','k');
text(15,70,['Data saved at:    ', my_save_data_dir],'fontsize',12,'fontweight','bold','Color','k');

% display participant's performace
patch([10 90 90 10],[25 25 60 60],[.8 .8 .8],'LineWidth',1,'FaceAlpha',.3);
text(15,55,["Participant's Performace"],'fontsize',14,'fontweight','bold','Color','k');
text(15,45,['General Performace:    % ', num2str(round(my_performance_total))],'fontsize',12,'fontweight','bold','Color','k');
text(15,40,['Old Stimuli:    % ', num2str(round(my_performace_old))],'fontsize',12,'fontweight','bold','Color','k');
text(15,35,['New Stimuli:    % ', num2str(round(my_performace_new))],'fontsize',12,'fontweight','bold','Color','k');
text(15,30,['Similar Stimuli:    % ', num2str(round(my_performace_sim))],'fontsize',12,'fontweight','bold','Color','k');

axis([10 90 25 90]);
hold off;

end

