function  svm_learning(~)
  disp('begin svm learning');
%   addpath('./lib/liblinear');
%   if ~is_SVM_used
%       return;
%   else
%       disp('svm learning begins......')
%   end
 %%%%%%%%%% TO Do  %%%%%%%%%%%%%
  % if you use SVM as classifier. please computing the normal vector "w". Please
  % remove following code, and rewrite your code.
  
  nClass = 5;
  nImgPerClass = 60;
  vectorPath = 'training/code_vector/';
  trainMatrix=[];
  trainLabel = [];
  for classID = 1 : nClass
      for imgID = 1 : nImgPerClass
        load([vectorPath,'codeVector_',num2str(classID),'_',num2str(imgID),'.mat'], 'codeVector');
		trainMatrix = [trainMatrix,codeVector];
		trainLabel = [trainLabel;classID];
      end
  end
  
  trainMatrix = sparse(double(trainMatrix'));  
   disp ('calling svmtrain...');
  [model] = train(trainLabel,trainMatrix,'-s 2');
%    model = svmtrain(trainLabel,trainMatrix','-s 0 -t 3');

  save('training/SVM/model.mat','model')
  
end