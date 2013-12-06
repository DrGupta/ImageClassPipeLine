function expt = computeEntropyCorrScore(expt, phase)
if strcmp(phase, 'training')
    % correlation computation for training phase
    nImage = size(expt.trainList,1);
    entropyVec = zeros(nImage,1);
    ratingVec = zeros(nImage,1);
    for i = 1 : nImage
        load(expt.trainImageEntropyMap(num2str(expt.trainList(i))), 'imageEntropy');
        entropyVec(i) = imageEntropy.entropy;
        ratingVec(i) = expt.dataSetListMap(num2str(expt.trainList(i)));       
    end
    % compute the correlation score
    expt.entropyVec = entropyVec;
    expt.ratingVec = ratingVec;
    
elseif strcmp(phase, 'testing')
    % correlation computation for testing phase
else
    disp('experiment phase not recognized');
    return;
end
end