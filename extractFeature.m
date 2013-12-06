function [expt] = extractFeature(expt, config, imageID)

imagePath = expt.trainImagePathMap(num2str(imageID));
% load the specified image
try
    image = imread(imagePath);
catch err
    disp(['unable to load image: ' imagePath]);
    disp(err.identifier());
end

% add a switch structure to check if file already exists
% if exist(expt.trainImageFeatureMap(num2sr(imageID)),'file')
%    disp('file already exists');
%    return;
% end

% ---------------------------------------------------------------------
% TODO : modify to a switch-case structure for different types of feature
% descriptors including 'phow', 'sift', 'dsift', 'surf', 'gist'
% ---------------------------------------------------------------------

if strcmpi(config.feature, 'phow')
        
    % set the parameters according to the configuration file
    featureParam = containers.Map();
    featureParam('Step') = str2double(config.featStep);
    featureParam('Color') = config.featColor;
    % using arrayfun and lambda function to convert cell of strings to
    % array of number inline and assigning it to a map structure
    featureParam('Sizes') = arrayfun(@(x) str2double(x), config.featSize);
    % --------------------------------------------------
    % params defined inline. TODO: change to configuration file later on
    featureParam('Fast') = true;
    featureParam('Verbose') = true;
    % --------------------------------------------------
      
    % convert the image to single for the vl_phow function
    image = im2single(image);
    % call the vl_feat library function
    [frame, descrs] = vl_phow(image, 'Step', featureParam('Step'), 'Color', featureParam('Color'), ...
        'Sizes', featureParam('Sizes'), 'Fast', featureParam('Fast'), 'Verbose', featureParam('Verbose'));
    
    % store the descrs to file
    image.frame = frame;
    image.descrs = descrs;
    image.sizes = featureParam('Sizes');
    image.height = size(image,1);
    image.width = size(image,2);
    image.id = imageID;
    
    % save to file
    save(expt.trainImageFeatureMap(num2str(imageID)), 'image');
    
    % -------------------------------------------------------------------
    % DEBUG
    % -------------------------------------------------------------------
    % echo successfully writen descriptor to screen
    disp(expt.trainImageFeatureMap(num2str(imageID)));
end

end