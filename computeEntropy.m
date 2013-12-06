function computeEntropy(expt, phase)

if strcmp(phase, 'training')
     % for each image in the training list
     nTrainList =numel(expt.trainList);
     for i = 1 : nTrainList
         try
             encodePath = expt.trainImageEncodedMap(num2str(expt.trainList(i)));
             imagePath = expt.trainImagePathMap(num2str(expt.trainList(i)));
             load(imagePath);   % --> image
             load(encodePath);  % --> idx
             % transpose the image.frame matrix
             scaleId = image.frame';
             % the patch size is in the 4th column
             scaleId = scaleId(:,4);
             imgEntropyScale = zeros(1,numel(image.sizes));
             % size(idx,1) == size(scaleId,1) should assert to true
             for j = 1 : numel(image.sizes)
                 size = image.sizes(j);
                 % encoded patches at a given scale
                 idxatscale = idx(scaleId==size);
                 % entropy of patches at a given scale
                 imgEntropyScale(j) = entropy(idxatscale);
             end
             imageEntropy.entropies = imgEntropyScale;
             imageEntropy.entropy = mean(imgEntropyScale);
             % save to file
             save(expt.trainImageEntropyMap(num2str(expt.trainList(i))), 'imageEntropy');
         catch err
             disp(err.identifier());
         end
     end
elseif strcmp(phase, 'testing')
    % entropy computation for testing images
end
end