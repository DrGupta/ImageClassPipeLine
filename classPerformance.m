function expt = classPerformance(expt)
% expt.predLabel  -> classifier output
% expt.testLabel  -> groundTruth

disp(size(expt.testLabel));
disp(size(expt.predLabel));

eval = evaluate(expt.testLabel, expt.predLabel);
expt.accuracy = eval(1);
expt.sensitivity = eval(2);
expt.specificity = eval(3);
expt.precision = eval(4);
expt.recall = eval(5);
expt.fmeasure = eval(6);
expt.gmean = eval(7);

return;
end


function EVAL = evaluate(groundtruth,predicted)
% This fucntion evaluates the performance of a classification model by 
% calculating the common performance measures: Accuracy, Sensitivity, 
% Specificity, Precision, Recall, F-Measure, G-mean.
% Input: ACTUAL = Column matrix with actual class labels of the training
%                 examples
%        PREDICTED = Column matrix with predicted class labels by the
%                    classification model
% Output: EVAL = Row matrix with all the performance measures

idx = (groundtruth==1);

p = length(groundtruth(idx));
n = length(groundtruth(~idx));
N = p+n;

tp = sum(groundtruth(idx) == predicted(idx));
tn = sum(groundtruth(~idx) == predicted(~idx));
fp = n-tn;
% fn = p-tp;

tp_rate = tp/p;
tn_rate = tn/n;

accuracy = (tp+tn)/N;
sensitivity = tp_rate;
specificity = tn_rate;
precision = tp/(tp+fp);
recall = sensitivity;
f_measure = 2*((precision*recall)/(precision + recall));
gmean = sqrt(tp_rate*tn_rate);

EVAL = [accuracy sensitivity specificity precision recall f_measure gmean];
end