function feature_extraction(filelist, outputFile, classID, imgID, imgPerClass,algorithm)
% -------------------------------------------------------------------------    
% In this function, we read a training images and extract
% feature on it. All those features is recorded in struct array 'featurePatch'. 
% Each element of 'featurePatch' is a struct including only one member:
% This member is "patch" which record extracting patch itself. 
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Read in images to a structure based on the list
% -------------------------------------------------------------------------
Im = im2double(imread(filelist{(classID-1)*imgPerClass+imgID,1}));


% -------------------------------------------------------------------------
% Computer feature path struct
% -------------------------------------------------------------------------
featurePatch = extractPatch(Im,algorithm); %#ok<NASGU>

% -------------------------------------------------------------------------
% save feature patches to file
% -------------------------------------------------------------------------
save([outputFile,'/feature/featurePatch_',num2str(classID),'_',num2str(imgID),'.mat'],'featurePatch');

end