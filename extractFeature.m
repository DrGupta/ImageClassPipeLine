function [expt] = extractFeature(expt, config, imageID)

imagePath = expt.trainImagePathMap(num2str(imageID));
% load the specified image
try
    img = imread(imagePath);
catch err
    disp(['unable to load image: ' imagePath]);
    disp(err.identifier());
    return;
end


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
    featureParam('Verbose') = false;
    % --------------------------------------------------
      
    % convert the image to single for the vl_phow function
    img = im2single(img);
    % call the vl_feat library function
    [frame, descrs] = vl_phow(img, 'Step', featureParam('Step'), 'Color', featureParam('Color'), ...
        'Sizes', featureParam('Sizes'), 'Fast', featureParam('Fast'), 'Verbose', featureParam('Verbose'));
    
    % store the descrs to file
    image.frame = frame;
    image.descrs = descrs;
    image.sizes = featureParam('Sizes');
    image.height = size(img,1);
    image.width = size(img,2);
    image.id = imageID;
    
    % save to file
    save(expt.trainImageFeatureMap(num2str(imageID)), 'image');
    
    % -------------------------------------------------------------------
    % DEBUG
    % -------------------------------------------------------------------
    % echo successfully writen descriptor to screen
    disp(expt.trainImageFeatureMap(num2str(imageID)));
    
elseif strcmpi(config.feature, 'dsift')
    % set the parameters according to the configuration file
    featureParam = containers.Map();
    featureParam('Step') = str2double(config.featStep);
    featureParam('Size') = str2double(config.featSize);
    % --------------------------------------------------------------------
    featureParam('Fast') = true;
    featureParam('Verbose') = false;
    % --------------------------------------------------------------------
    
    % convert the image to single for the dsift function
    if isrgb(img)
        img = single(vl_imdown(rgb2gray(img)));
    else
        img = single(vl_imdown(img));
    end
%     [frame, descrs] = vl_dsift(img, 'Step', featureParam('Step'), 'Size',
%     featureParam('Size'),  'Fast', true, 'Verbose', false);
    [frame, descrs] = vl_dsift(img, 'size', featureParam('Size'), 'step', featureParam('Step'));
    
    % store the descrs to file
    image.frame = frame;
    image.descrs = descrs;
    image.size = featureParam('Size');
    image.width = size(img,1);
    image.height = size(img,2);
    image.id = imageID;
    
    % save the image struct to file
    save(expt.trainImageFeatureMap(num2str(imageID)), 'image');
    
    % -------------------------------------------------------------------
    % DEBUG
    % -------------------------------------------------------------------
    % echo successfully writen descriptor to screen
    disp(expt.trainImageFeatureMap(num2str(imageID)));
    
end

end