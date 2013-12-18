% testSVM
% use the encoded feature descriptors from both the training and the tesing
% phase to test the classification performance. Use the learnt classifier
% from the training phase

function expt = testSVM(expt)
% create the trainLabel vector and the training feature data matrix
nTestList =numel(expt.testList);
testData = [];
testLabel = [];
%
for i = 1 : nTestList
    % try loading the encoded representation of each image in the test list
    load(expt.testImageEncodedMap(num2str(expt.testList(i))), 'idx');
    feat = []; % initialize the idx to null at the start of each iteration in the case where encoded file does not exist
    feat = idx.idx;
    testData = vertcat(testData, feat);
    testLabel = vertcat(testLabel, expt.testList(i,2));
    % ------------------------------------------------------------------
    % use the svm model in the file or in the expt structure
    svmModel = expt.svmModel;    
    [svmPredLabel, svmAcc, svmProbEst] = svmpredict(testLabel, testData, svmModel);
    % store the prediction results to expt structure
    expt.predLabel = predLabel;
    expt.acc = acc;
    expt.probEst = probEst;
    % ------------------------------------------------------------------
    % In case of cross-validation the variable to be stored on the
    % structure will change accordingly
    % ------------------------------------------------------------------
    
    % write the results to file
    save([expt.testSVMDir, 'svmPredLabel.mat'], 'svmPredLabel');
    save([expt.testSVMDir, 'svmAcc.mat'], 'svmAcc');
    save([expt.testSVMDir, 'svmProbEst.mat'], 'svmProbEst');
    
end

end