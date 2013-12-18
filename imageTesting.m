function expt = imageTesting(config, expt)

fprintf('Phase is %s\n', expt.phase);

% --------------------------------------------------------------------
% Extract Features
% --------------------------------------------------------------------


if(strcmp(config.extractFeatures,'true'))
       
    % iterate over the testing list
    nTestImages = max(size(expt.testList));
    for count = 1 : nTestImages
        extractFeature(expt, config, expt.testList(count));
    end
end


% --------------------------------------------------------------------
% Test Codebook
% --------------------------------------------------------------------

% The test codebook is the same as train codebook!

% --------------------------------------------------------------------
% Encode Testing Images
% --------------------------------------------------------------------

 nTestImages = numel(expt.testList);
    for count = 1 : nTestImages
%          if ~exist(expt.testImageEncodedMap(num2str(expt.testList(count))), 'file')
            expt = encodeImage(expt, config, expt.testList(count), count);
%          else
%              fprintf('%s %s\n', expt.testImageEncodedMap(num2str(expt.testList(count))), ' already exists.');
%          end
    end

% --------------------------------------------------------------------
% Compute the entropy of each image at multiple scales
% -------------------------------------------------------------------- 

 nTestList =numel(expt.testList);
    for i = 1 : nTestList
        encodePath = expt.testImageEncodedMap(num2str(expt.testList(i)));
        featurePath = expt.testImageFeatureMap(num2str(expt.testList(i)));
        if exist(encodePath, 'file') && exist(featurePath, 'file')
            expt = computeEntropy(expt, i);
        end
    end
% --------------------------------------------------------------------
% Compute the correlation score between the aesthetic rank and entropies
%

 expt = computeEntropyCorrScore(expt);

% --------------------------------------------------------------------
% Test classification
% --------------------------------------------------------------------

 expt = testSVM(expt);
 
% ---------- DEBUG ------------------------
 disp('testing phase done');
% -----------------------------------------

end