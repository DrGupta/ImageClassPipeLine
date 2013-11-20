function image_class_training(filelist_training,config)
% --------------------------------------------------------------------
% 
% --------------------------------------------------------------------  


  
  if(strcmp(config.algorithm.extractFeat,'true'))
    disp('computing feature descriptors') %   DEBUG:
    for classID = 1 : config.dataset.nClass   % five class.
       for imgID = 1 : config.dataset.nImgPerClass_training % 60 training image number in each class.
          disp(['extraction: the ',num2str(imgID),' th image in class ', num2str(classID), ' is processing']) % DEBUG:
          feature_extraction(filelist,'training',classID,imgID,60,config.algorithm);
          feature_description('training', 'training', classID, imgID,config.algorithm);
       end
    end
  end
  
% --------------------------------------------------------------------
% Train codebook
% --------------------------------------------------------------------    
   if(strcmp(config.algorithm.trainBook,'true'))
        codebook_computation();
   end
   
   disp('code vector computing begins......')
   for classID = 1 : 5
      parfor imgID = 1 : 60
        disp(['coding:  the ',num2str(imgID),' th image in class ', num2str(classID), ' is processing'])
        code_vector('training', 'training', classID, imgID,config.algorithm);
      end
   end
   
   
   %If you don't use SVM as classifier, you can ignore svm_learning
   %function and set 'is_SVM_used = false'
   is_SVM_used = false;
   if strcmp(config.algorithm.svm,'true')
    is_SVM_used = true;   
   end 
   
   svm_learning(is_SVM_used); 
   
   disp('Training phase is done!')
end