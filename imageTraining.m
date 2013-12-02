function [expt] = imageTraining(config, expt)
% --------------------------------------------------------------------
% Extract Features
% --------------------------------------------------------------------  

if(strcmp(config.extractFeatures,'true'))
    % ---------------------------------------------------------------
    % DEBUG
    % ---------------------------------------------------------------
    % echo to screen commencement of extraction process
    disp('extracting features ...');
    
    % iterate over the training list
    nTrainImages = max(size(expt.trainList));
    for count = 1 : nTrainImages
        extractFeature(expt, config, expt.trainList(count));
    end
end


% ======================================================================
  
 
% --------------------------------------------------------------------
% Train codebook
% --------------------------------------------------------------------    
   if(strcmp(config.trainCodeBook,'true'))
       % TODO : if the codebook already exists then computation could be
       % averted, change this setting later
       % ------------------------------------------------------------
       % DEBUG
       % ------------------------------------------------------------
       disp('computing codebook...')
%        computeCodeBook(expt);
   end
   
   
% ======================================================================

% --------------------------------------------------------------------
% Encode Training Images
% --------------------------------------------------------------------   
   
   disp('code vector computing begins ...')
   
        disp(['coding:  the ',num2str(imgID),' th image in class ', num2str(classID), ' is processing'])
%         code_vector('training', 'training', classID, imgID, config.algorithm);
      

   
% ======================================================================

% --------------------------------------------------------------------
% Train classifier
% --------------------------------------------------------------------
   
   
   %If you don't use SVM as classifier, you can ignore svm_learning
   %function and set 'is_SVM_used = false'
   is_SVM_used = false;
   if strcmp(config.svm,'true')
    is_SVM_used = true;   
   end 
   
%    svm_learning(is_SVM_used); 
   
   disp('Training phase is done!')
end