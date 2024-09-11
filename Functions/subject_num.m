%% function help
% this function opens a ui to enter subject number
% written by: Morteza Mooziri
% last update: Mar 12, 2024

%%%%% Input %%%%%
% none

%%%%% Output %%%%%
% my_subject_num = participant number 

%% function
function my_subject_num = subject_num()

my_dlgquestion = {'\bf Enter Subject Number'};
my_dlgtitle = 'Subject Number';
my_dlgdims = [1 50];
my_opts.Interpreter = 'tex';
my_definput = {''};

my_subject_name = inputdlg(my_dlgquestion, my_dlgtitle, my_dlgdims, my_definput, my_opts);
my_subject_num = str2num(my_subject_name{1});

end

