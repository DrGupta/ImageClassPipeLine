function expt = imageTraining(config, expt)
% processing training images in the dataset for semantic and entropic
% content measure
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
        if ~exist(expt.trainImageFeatureMap(num2str(expt.trainList(count))),'file')
            extractFeature(expt, config, expt.trainList(count));
        end
    end
end


% ======================================================================
  
 
% --------------------------------------------------------------------
% Train codebook
% --------------------------------------------------------------------    
   if(strcmp(config.trainCodeBook,'true'))
      codeBookPath = fullfile(expt.trainCodeBookDir, [ config.feature 'trainCodeBook.mat']);
      if ~exist(codeBookPath, 'file')
        disp('computing the dictionary');
        expt = computeCodeBook(expt, config);
      else
        fprintf('%s %s\n', codeBookPath, ' already exists.');
        disp('loading the dictionary from file');
        load(codeBookPath, 'dictionary');
        expt.codeBook = dictionary;        
      end
   end   
   
% ======================================================================

% --------------------------------------------------------------------
% Encode Training Images
% --------------------------------------------------------------------   

    nTrainImages = max(size(expt.trainList));
    for count = 1 : nTrainImages
         if ~exist(expt.trainImageEncodedMap(num2str(expt.trainList(count))), 'file')
            expt = encodeImage(expt, config, expt.trainList(count), count);
         else
             fprintf('%d %s %s\n', count, expt.trainImageEncodedMap(num2str(expt.trainList(count))), ' already exists.');
         end
    end
   
% ======================================================================

% --------------------------------------------------------------------
% Compute the entropy of each image at multiple scales
% --------------------------------------------------------------------  
    nTrainList =numel(expt.trainList);
    for i = 1 : nTrainList
        encodePath = expt.trainImageEncodedMap(num2str(expt.trainList(i)));
        featurePath = expt.trainImageFeatureMap(num2str(expt.trainList(i)));
        if exist(encodePath, 'file') && exist(featurePath, 'file')
            expt = computeEntropy(expt, i);
        end
    end
% --------------------------------------------------------------------
% Compute the correlation score between the aesthetic rank and entropies
    
    expt = computeEntropyCorrScore(expt);

% --------------------------------------------------------------------
% use the entropic scores of each patch to compute a classifier for the
% image

% ======================================================================

% --------------------------------------------------------------------
% Train classifier
% --------------------------------------------------------------------
   
% Train a classifier using the encoded representation of the images using
% the entropic descriptors  

    expt = trainSVM(expt);
   
    disp('Training phase is done!')
end