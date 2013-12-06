function expt = computeCodeBook(expt, config)
% compute a codebook (or dictionary)

% load a subset of the training images to a matrix which will be utilized
% for computing the codebook

% config.numImageTraining
% config.numImageTesting

% Each image has approximately 10,000 descriptors in it.
% There are 3000 images for training, which means there are 30 million
% feature vectors, each of 384 dimensions.
% Randomly select 1% of the descriptors in each image towards the
% computation of the codebook. Each cluster will subsequently have
% approximately 100 descriptors.

% Note that the database is not static. Consequentely some images may not
% be available. Therefore allow for the possibility of broken images, or
% absent descriptors in the selection process.

% ----------------------------------------------------------------------
% Random select images
    % check to see descriptors of image exists otherwise next random image

% Random select 1 % descriptors from each image

numImageTraining = str2double(config.numImageTraining); % number of training images
numSamplePerImage = expt.numSamplePerImage; % number of descriptors to sample from each image
count = 0;
% if strcmp(config.featColor,'gray') || strcmp(config.feature, 'dsift')
%     descrsDim = 128;
% else
%     descrsDim = 384;
% end
% descrsSample = zeros(numImageTraining*numSamplePerImage, descrsDim);
descrsSample = [];
for i = 1 : max(size(expt.trainList))
    try
        featurePath = expt.trainImageFeatureMap(num2str(expt.trainList(i)));
        imgfeat = load(featurePath);
        % image structure has the descriptors
        descrs = imgfeat.image.descrs;
        % transpose the descriptor matrix
        descrs = descrs';
        if sum(sum(descrs,2)==0) ~= 0
            continue;
        end            
        nDescrs = size(descrs,1); % the number of rows is the number of descriptor feature vectors
        % randomly selection of 1% of the descriptors
        rndDescrs = descrs(randsample(nDescrs,numSamplePerImage),:);
%       descrsSample( count*numSamplePerImage + 1 : (count+1)*numSamplePerImage , :) = rndDescrs;
        descrsSample = vertcat(descrsSample, rndDescrs);
        % increment count
        count = count + 1;
    catch err
        disp(err.identifier());
    end
        
    % when required number of images have been acquired stop the process
    if count >= numImageTraining
        break;
    end
        
end

% -----------------------------------------------------------------------
% DEBUG
% -----------------------------------------------------------------------
disp(sum(sum(descrsSample,2)==0));
disp(size(descrsSample))

% ------------------------------------------------------------------------
% using k-means clustering to compute codebook

dictionarySize = str2double(config.codeNum);
% opts = statset('Display', 'final', 'MaxIter', 50);
% [~,codebook] = kmeans(descrsSample, dictionarySize ,'emptyaction', 'singleton', 'start', 'sample', 'Options', opts);

% use transpose of the descriptor matrix
descrsSample = double(descrsSample);
[codebook, ~] = vl_kmeans(descrsSample', dictionarySize, 'verbose','Initialization', 'plusplus', 'MaxNumIterations', 100, 'distance', 'l1');


% ------------------------------------------------------------------------

% transpose the codebook again
dictionary = codebook';
expt.codeBook = codebook';
% write codebook to file
codeBookPath = fullfile(expt.trainCodeBookDir, [ config.feature 'trainCodeBook.mat']);
save(codeBookPath, 'dictionary');


end