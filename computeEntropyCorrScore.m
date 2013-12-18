function expt = computeEntropyCorrScore(expt)
if strcmp(expt.phase, 'training')
    % correlation computation for training phase
    nImage = size(expt.trainList,1);
    entropyVec = zeros(nImage,1);
    ratingVec = zeros(nImage,1);
    %
    for i = 1 : nImage
        entropyFile = expt.trainImageEntropyMap(num2str(expt.trainList(i)));
        if exist(entropyFile, 'file')
            try
            load(entropyFile, 'imageEntropy');
            catch err
                disp(err.identifier());
            end
        entropyVec(i) = imageEntropy.entropy;
        ratingVec(i) = expt.dataSetListMap(num2str(expt.trainList(i))); 
        end
    end
    % compute the correlation score
    % --------  REMOVE ------------------------
    expt.entropyVec = entropyVec;
    expt.ratingVec = ratingVec;
    % -----------------------------------------
    
    expt.trainEntropyVec = entropyVec;
    expt.trainRatingVec = ratingVec;
    
elseif strcmp(expt.phase, 'testing')
    % correlation computation for testing phase
    nImage = size(expt.testList,1);
    entropyVec = zeros(nImage,1);
    ratingVec = zeros(nImage,1);
    %
    for i = 1 : nImage
        entropyFile = expt.testImageEntropyMap(num2str(expt.testList(i)));
        if exist(entropyFile, 'file')
            try
            load(entropyFile, 'imageEntropy');
            catch err
                disp(err.identifier());
            end
            entropyVec(i) = imageEntropy.entropy;
            ratingVec(i) = expt.dataSetListMap(num2str(expt.trainList(i)));
        end
    end
    % compute the correlation score
    % --------  REMOVE ------------------------
    expt.entropyVec = entropyVec;
    expt.ratingVec = ratingVec;
    % -----------------------------------------
   
    expt.testEntropyVec = entropyVec;
    expt.testRatingVec = ratingVec;
    
else
    disp('experiment phase not recognized');
    return;
end
end