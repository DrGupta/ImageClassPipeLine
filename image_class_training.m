function image_class_training(filelist,config,expt)
% --------------------------------------------------------------------
% Training the classification system. First feature descriptors are
% extracted from training images based on the imagelists computed apriori.
% Then a codebook is trained using the algorithm specified in the
% configuration file of the experiment. Each training image is then encoded
% based on this codebook. Finally a classifier is trained using the encoded
% image descriptors.
% --------------------------------------------------------------------  


% --------------------------------------------------------------------
% Compute Descriptors for each training image
% --------------------------------------------------------------------  
  if(strcmp(config.algorithm.extractFeat,'true'))
    disp('computing feature descriptors') %   DEBUG:
    for classID = 1 : config.dataset.nClass   % five class.
       for imgID = 1 : config.dataset.nImgPerClass_training % 60 training image number in each class.
          disp(['descriptor: ',num2str(imgID),' image in class ', num2str(classID), ' is processing']) % DEBUG:
          
          feature_extraction(filelist,'training',classID,imgID, config.dataset.nImgPerClass_training,config.algorithm);
          
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
   
% --------------------------------------------------------------------
% Encode training images based on the trained codebook
% --------------------------------------------------------------------   
   disp('code vector computing begins......')
   for classID = 1 : config.dataset.nClass % 5 Note that parfor cannot be nested      
      parfor imgID = 1 : config.dataset.nImgPerClass_training % 60
        disp(['coding:  ',num2str(imgID),' image in class ', num2str(classID), ' ... '])
        code_vector('training', 'training', classID, imgID, config.algorithm); %#ok<PFBNS>
      end
   end

% --------------------------------------------------------------------
% Call SVM training
% --------------------------------------------------------------------   
   
   %If you don't use SVM as classifier, you can ignore svm_learning function and set 'is_SVM_used = false'   
   if strcmp(config.algorithm.svm,'true')
    is_SVM_used = true;
   else
    is_SVM_used = false;
   end 
      
   svm_learning(is_SVM_used); 
   
   disp('Training phase is done!') % DEBUG : echo end of training run
end