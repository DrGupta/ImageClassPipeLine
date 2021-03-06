% testSVM
% use the encoded feature descriptors from both the training and the tesing
% phase to test the classification performance. Use the learnt classifier
% from the training phase

function expt = testSVM(expt)
% create the trainLabel vector and the training feature data matrix
nTestList = max(size(expt.testList));
testData = [];
testLabel = [];
%
for i = 1 : nTestList
    try
        load(expt.testImageEntropyMap(num2str(expt.testList(i))));
        feat = imageEntropy.entropies;
        testData = [testData; feat];
        testLabel = [testLabel; expt.testList(i,2)];
    catch err
        disp(err.identifier());
    end        
end
    size(testData)
    size(testLabel)
    
    % ------------------------------------------------------------------
    % use the svm model in the file or in the expt structure
    svmModel = expt.svmModel;    
    [svmPredLabel, svmAcc, svmProbEst] = svmpredict(testLabel, testData, svmModel);
    % store the prediction results to expt structure
    expt.predLabel = svmPredLabel;
    expt.acc = svmAcc;
    expt.probEst = svmProbEst;
    expt.testLabel = testLabel;
    % ------------------------------------------------------------------
    % In case of cross-validation the variable to be stored on the
    % structure will change accordingly
    % ------------------------------------------------------------------
    
    % write the results to file
    save(fullfile(expt.testSVMDir, 'svmPredLabel.mat'), 'svmPredLabel');
    save(fullfile(expt.testSVMDir, 'svmAcc.mat'), 'svmAcc');
    save(fullfile(expt.testSVMDir, 'svmProbEst.mat'), 'svmProbEst');
    
end