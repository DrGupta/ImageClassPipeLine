% ImageClassificationPipeline
% root : /export/home/gupta/Dropbox/CodeX/ImagePipeLine

% -----------------------------
% house-keeping and data-check
% -----------------------------

% clear memory of previous variables with erroneous data
clear; 

configFileName = 'configPHOW2.ini';
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
expt = imageTesting(config,expt);

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