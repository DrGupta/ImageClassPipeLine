function expt = trainSVM(expt)

% create the trainLabel vector and the training feature data matrix
nTrainList =numel(expt.trainList);
trainData = [];
trainLabel = [];
for i = 1 : nTrainList
    idx = []; % initialize the idx to null at the start of each iteration in the case where encoded file does not exist
    try
        load(expt.trainImageEncodedMap(num2str(expt.trainList(i))), 'idx');
    catch err
        disp(err.identifier());
    end
    trainData = vertcat(trainData, idx);
    trainLabel = vertcat(trainLabel, expt.trainList(i,2));
    model = svmtrain(trainLabel, trainData);
    expt.model = model;
        
end
end