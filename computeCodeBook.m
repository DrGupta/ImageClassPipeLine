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
descrsDim = 128;
descrsSample = zeros(numImageTraining*numSamplePerImage, descrsDim);
%
% ----------------------------------------------------------

% loop for each size of the patch in the descriptor
for j = 1 : numel(expt.sizes)
    featSize = expt.sizes(j);
    dictionarySize = str2double(config.codeNum);
    

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
             scaleId = image.frame;
             scaleId = scaleId';
             % the patch size is in the 4th column
             scaleId = scaleId(:,4);
             
             descrs = image.descrs(scaleId==featSize,:);
            
            % transpose the descriptor matrix
            descrs = descrs';
            if sum(sum(descrs,2)==0) ~= 0
                continue;
            end            
            nDescrs = size(descrs,1); % the number of rows is the number of descriptor feature vectors
            % randomly selection of 1% of the descriptors
            rndDescrs = descrs(randsample(nDescrs,numSamplePerImage),:);
    %       descrsSample( count*numSamplePerImage + 1 : (count+1)*numSamplePerImage , :) = rndDescrs;
            descrsSample( numSamplePerImage*(i-1)+1 : numSamplePerImage*i, 1:128) = rndDescrs;    
        catch err
            disp(err.identifier());
        end


    end

    % using k-means clustering to compute codebook



    % use transpose of the descriptor matrix
    descrsSample = double(descrsSample);
    fprintf('%d %d %d', j, size(descrsSample,1), size(descrsSample,2));
    [codebook, ~] = vl_kmeans(descrsSample', dictionarySize, 'verbose','Initialization', 'plusplus', 'MaxNumIterations', 20, 'distance', 'l1');

    % transpose the codebook again
    dictionary = codebook';
    expt.codeBook{j} = dictionary;

end
% ----------------------------------------------------------
% write codebook to file
codeBookPath = fullfile(expt.trainCodeBookDir, [ config.feature num2str(expt.dictionarySize) num2str(expt.numSamplePerImage) 'CodeBook.mat']);
save(codeBookPath, 'dictionary');


end