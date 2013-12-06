function [config, expt] = overture(configFileName)

defaultConfigFileName = 'config.ini';
if nargin == 0
    configFileName = defaultConfigFileName;
end

config = ExptConfig(configFileName);

% ------------------------------------------------------------------------
expt = struct(); % create an empty expt object for data during the expt run

% to log the experiment run record the data and time
expt.date = date(); 
expt.time = num2str(now);

% the basic paths to files for the experiment
expt.dataDir = '/cluster/gupta/DataBase/' ;
expt.imageDir = '/images/';
expt.imageFmt = '.jpg';
expt.exptDir = '/cluster/gupta/Expt/';
expt.logDir = '/Log/';
expt.numSamplePerImage = 100;
expt.dictionarySize = str2double(config.codeNum);

% ---------------------------------------------------------------------
% TODO
% ---------------------------------------------------------------------
% create a date and time tag for experiment files
formatDate = 'ddmmyy';
expt.date = datestr(now,formatDate);
% ---------------------------------------------------------------------
% create directories for files generated during the experiment
% (file persistence to be decided later)
% ---------------------------------------------------------------------

% append the dataSetName to the root experiment directory
expt.currDir = fullfile(expt.exptDir, config.dataSetName);

% create the current experiment directory if it does not already exist
if ~ exist(expt.currDir,'dir')
    mkdir(expt.currDir);
end

if strcmpi(config.dataSetName, 'DPchallenge')
    expt.dataSetFile = fullfile(expt.dataDir, config.dataSetName, ...
        'dpchallengeimagelist.txt' );
end

% create the directories in training and test sub-directoryies
expt.trainingDir = fullfile(expt.exptDir, config.dataSetName, 'training');
expt.testingDir = fullfile(expt.exptDir, config.dataSetName, 'testing');
%
if ~ exist(expt.trainingDir,'dir')
    mkdir(expt.trainingDir);
end
%
if ~ exist(expt.testingDir,'dir')
    mkdir(expt.testingDir);
end
%


% ---------------------------------------------------------------------
expt.trainCodeBookDir = fullfile(expt.trainingDir , 'codeBook');
%
if ~ exist(expt.trainCodeBookDir,'dir')
    mkdir(expt.trainCodeBookDir);
end
%
expt.trainCodeVectorDir = fullfile(expt.trainingDir, 'codeVector');
%
if ~ exist(expt.trainCodeVectorDir,'dir')
    mkdir(expt.trainCodeVectorDir);
end
%
expt.trainFeatureDir = fullfile(expt.trainingDir, 'feature');
%
if ~ exist(expt.trainFeatureDir,'dir')
    mkdir(expt.trainFeatureDir);
end
%
expt.trainSVMDir = fullfile(expt.trainingDir, 'svm');
%
if ~ exist(expt.trainSVMDir,'dir')
    mkdir(expt.trainSVMDir);
end
%
expt.trainAttributeDir = fullfile(expt.trainingDir, 'attributes');
%
if ~ exist(expt.trainAttributeDir,'dir')
    mkdir(expt.trainAttributeDir);
end
%
expt.trainEntropyDir = fullfile(expt.trainingDir, 'entropy');
%
if ~ exist(expt.trainEntropyDir, 'dir')
    mkdir(expt.trainEntropydir);
end

% ---------------------------------------------------------------------
expt.testCodeBookDir = fullfile(expt.testingDir, 'codeBook');
%
if ~ exist(expt.testCodeBookDir,'dir')
    mkdir(expt.testCodeBookDir);
end
%
expt.testCodeVectorDir = fullfile(expt.testingDir, 'codeVector');
%
if ~ exist(expt.testCodeVectorDir,'dir')
    mkdir(expt.testCodeVectorDir);
end
%
expt.testFeatureDir = fullfile(expt.testingDir, 'feature');
%
if ~ exist(expt.testFeatureDir,'dir')
    mkdir(expt.testFeatureDir);
end
%
expt.testSVMDir = fullfile(expt.testingDir, 'svm');
%
if ~ exist(expt.testSVMDir,'dir')
    mkdir(expt.testSVMDir);
end
%
expt.testAttributeDir = fullfile(expt.testingDir, 'attributes');
%
if ~ exist(expt.testAttributeDir,'dir')
    mkdir(expt.testAttributeDir);
end
%
expt.testEntropyDir = fullfile(expt.testingDir, 'entropy');
%
if ~ exist(expt.testEntropyDir, 'dir')
    mkdir(expt.testEntropyDir);
end

% ---------------------------------------------------------------------
% the location of images is in a central image dataset repository, it not
% located in the experiment directory
expt.imagePath = fullfile(expt.dataDir, config.dataSetName, expt.imageDir);
%
if ~ exist(expt.imagePath,'dir')
    mkdir(expt.imagePath);
end
% -----------------------------------------------------------------------
% the format of the encoded feature representation of an image
% TODO : convert to switch-case structure later
% -----------------------------------------------------------------------

if strcmpi(config.svm, 'true')
    expt.codeVectorFmt = '.svm';
else
    expt.codeVectorFmt = '.svm'; % this is a stub
end
    

end
