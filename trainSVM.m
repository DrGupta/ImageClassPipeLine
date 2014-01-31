function expt = trainSVM(expt)

% create the trainLabel vector and the training feature data matrix
nTrainList =numel(expt.trainList);
trainData = [];
trainLabel = [];
for i = 1 : nTrainList
    try
        load(expt.trainImageEntropyMap(num2str(expt.trainList(i))), 'imageEntropy');
        feat = imageEntropy.entropies;
        trainData = vertcat(trainData, feat);
        trainLabel = vertcat(trainLabel, expt.trainList(i,2));
    catch err
        disp(err.identifier());
    end        
end
svmModel = svmtrain(trainLabel, trainData);
expt.svmModel = svmModel;
expt.trainLabel = trainLabel;
% -----------------------------------------------
% save the svm model to file
svmFileName = [expt.trainSVMDir, 'trainSVM.mat'];
save(svmFileName, 'svmModel');        
% -----------------------------------------------
end