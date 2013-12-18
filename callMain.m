function callMain(configFileName)

if nargin == 0
    configFileName = 'configPHOW2.ini';
end
[config, expt] = overture(configFileName); 

% -----------------------------
% build image lists for training and testing
% -----------------------------
expt = createFileLists(config,expt);

% -----------------------------
% Training :
% Learning Codebook, Coding training images, Learning Classifier
% -----------------------------

expt.phase = 'training';
expt = imageTraining(config, expt);

% -----------------------------
% Testing :
% Coding testing images, Classification, Performance evaluation
% -----------------------------

expt.phase = 'testing';
expt = imageTesting(expt.filelist_perm,config.algorithm);

% -----------------------------
% Report generation, Logging
% -----------------------------

% acc = accuracy_calcu();

% -----------------------------
% Store the experiment and configuration files at the end of the expt.
% -----------------------------
configStructFileName = fullfile(expt.currDir, expt.logDir, [expt.date 'exptConfig.mat']);
exptStructFileName = fullfile(expt.currDir, expt.logDir, [expt.date 'expt.mat']);
save(configStructFileName, 'config');
save(exptStructFileName, 'expt');
end