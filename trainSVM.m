function expt = trainSVM(expt)

% create the trainLabel vector and the training feature data matrix
nTrainList =numel(expt.trainList);
trainData = [];
trainLabel = [];
for i = 1 : nTrainList    
    try
        load(expt.trainImageEncodedMap(num2str(expt.trainList(i))), 'idx');
        feat = []; % initialize the idx to null at the start of each iteration in the case where encoded file does not exist
        feat = idx.idx;
        trainData = vertcat(trainData, feat);
        trainLabel = vertcat(trainLabel, expt.trainList(i,2));
        svmModel = svmtrain(trainLabel, trainData);
        expt.model = svmModel;
        % -----------------------------------------------
        % save the svm model to file
        svmFileName = [expt.trainSVMDir, 'trainSVM.mat'];
        save(svmFileName, 'svmModel');        
        % -----------------------------------------------        
    catch err
        disp(err.identifier());
    end 
end
end