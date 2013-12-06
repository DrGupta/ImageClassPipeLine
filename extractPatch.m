function featurePatch = extractPatch(image,algorithm)
% -----------------------------------------------------------------------
% Current implementation of patch uses the entire images, but this should
% change to focus on local regions using a spatial pyramid approach
% -----------------------------------------------------------------------
    featureTypeList = algorithm.feature;
    featureTypes= regexp(featureTypeList, ',', 'split');
    for type=featureTypes
      switch type{1}
          case 'sift' 
              [~,~,cch] = size(image);
              Img = rgb2gray(repmat(image,[1,1,4-cch])); 
              featurePatch.sift=Img;
          case 'surf'
              [~,~,cch] = size(image);
              Img = rgb2gray(repmat(image,[1,1,4-cch])); 
              featurePatch.surf=Img;
          case 'gist'
              [~,~,cch] = size(image);
              Img = rgb2gray(repmat(image,[1,1,4-cch])); 
              featurePatch.gist=Img;
      end
    end
end