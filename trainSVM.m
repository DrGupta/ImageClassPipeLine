function expt = trainSVM(expt)

% create the trainLabel vector and the training feature data matrix
nTrainList = max(size(expt.trainList));
trainData = [];
trainLabel = [];
for i = 1 : nTrainList
    try
        load(expt.trainImageEntropyMap(num2str(expt.trainList(i))));
        feat = imageEntropy.entropies;
        trainData = [trainData; feat];
        trainLabel = [trainLabel; expt.trainList(i,2)];
    catch err
        disp(err.identifier());
    end        
end
size(trainData)
size(trainLabel)
svmModel = svmtrain(trainLabel, trainData);
expt.svmModel = svmModel;
expt.trainLabel = trainLabel;
% -----------------------------------------------
% save the svm model to file
svmFileName = fullfile(expt.trainSVMDir, 'trainSVM.mat');
save(svmFileName, 'svmModel');        
% -----------------------------------------------
end