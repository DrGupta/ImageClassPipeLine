function expt = computeCodeBook(expt)
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

numImageTraining = str2double(expt.numTrain); % number of training images
numSamplePerImage = expt.numSamplePerImage; % number of descriptors to sample from each image
% descrsDim = 128;
% descrsSample = zeros(numImageTraining*numSamplePerImage, descrsDim);
% using k-means clustering to compute codebook
descrsSample = [];
dictionarySize = expt.dictionarySize;
dictionary = cell(1,numel(expt.sizes));
% ----------------------------------------------------------

% loop for each size of the patch in the descriptor
for j = 1 : numel(expt.sizes)
    featSize = str2double(expt.sizes{j});
    for i = 1 : numImageTraining
        try
            featurePath = expt.trainImageFeatureMap(num2str(expt.trainList(i)));
            % image structure has the descriptors
            try
                load(featurePath, 'image');   % --> image
            catch err
                disp(err.identifier());
                return;
            end
            % transpose the image.frame matrix
            scaleId = image.frame(4,:);
            descrs = image.descrs(:,scaleId==featSize);
            
            % transpose the descriptor matrix
            descrs = descrs';            
            nDescrs = size(descrs,1); % the number of rows is the number of descriptor feature vectors
            % randomly selection of 1% of the descriptors
            if nDescrs > numSamplePerImage
                rndDescrs = descrs(randsample(nDescrs,numSamplePerImage),:);
            else
                rndDescrs = descrs;
            end
%           descrsSample( count*numSamplePerImage + 1 : (count+1)*numSamplePerImage , :) = rndDescrs;
%           descrsSample( numSamplePerImage*(i-1)+1 : numSamplePerImage*i, 1:128) = rndDescrs;   
            descrsSample = [descrsSample ; rndDescrs];
        catch err
            disp(err.identifier());
        end
    end

    
    % use transpose of the descriptor matrix
    descrsSample = double(descrsSample);
    [codebook, ~] = vl_kmeans(descrsSample', dictionarySize, 'verbose', 'MaxNumIterations', 100, 'algorithm', 'elkan');
    % transpose the codebook again
    dictionary{j} = codebook';
    expt.codeBook{j} = codebook';

end
% ----------------------------------------------------------
% write codebook to file
%codeBookPath = fullfile(expt.trainCodeBookDir, [ config.feature num2str(expt.dictionarySize) num2str(expt.numSamplePerImage) 'CodeBook.mat']);
%save(codeBookPath, 'dictionary');


end