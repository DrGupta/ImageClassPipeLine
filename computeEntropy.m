function expt = computeEntropy(expt, i)

% ------------------------------------------------------------------------
% Training
% ------------------------------------------------------------------------
    if strcmp(expt.phase, 'training')     
         encodePath = expt.trainImageEncodedMap(num2str(expt.trainList(i)));
         featurePath = expt.trainImageFeatureMap(num2str(expt.trainList(i)));             
         try
            load(featurePath, 'image');   % --> image
         catch err
             disp(err.identifier());
             return;
         end
         try
            load(encodePath, 'idx');  % --> idx
         catch err
             disp(err.identifier());
             return;
         end
         % transpose the image.frame matrix
         scaleId = image.frame;
         scaleId = scaleId';
         % the patch size is in the 4th column
         scaleId = scaleId(:,4);
         imgEntropyScale = zeros(1,numel(image.sizes));
         % size(idx,1) == size(scaleId,1) should assert to true
         for j = 1 : numel(image.sizes)
             dictionary = expt.codeBook{j};
             size_ = image.sizes(j);
             % encoded patches at a given scale
             scaleId = scaleId';             
             codeids = idx.codeids;
             idxatscale = codeids(scaleId==size_);
             % entropy of patches at a given scale
             if numel(idxatscale) ~= 0
                ids = vl_binsum(zeros(size(dictionary', 2), 1), 1, double(idxatscale));
                imgEntropyScale(j) = entropy(ids);
             end            
             
             fprintf('%d %d %d %d\n', j, size_, imgEntropyScale(j), entropy(idx.idx));
             
         end
         imageEntropy.entropies = imgEntropyScale;
         imageEntropy.entropy = mean(imgEntropyScale);
         
         fprintf('%d %d %d\n', i, expt.trainList(i), mean(imgEntropyScale));
         % save to file
         fprintf('%d %s\n',i,expt.trainImageEntropyMap(num2str(expt.trainList(i))));
         save(expt.trainImageEntropyMap(num2str(expt.trainList(i))), 'imageEntropy');     
% ------------------------------------------------------------------------
% Testing
% ------------------------------------------------------------------------
    elseif strcmp(expt.phase, 'testing')
    % entropy computation for testing images
        encodePath = expt.testImageEncodedMap(num2str(expt.testList(i)));
         featurePath = expt.testImageFeatureMap(num2str(expt.testList(i)));             
         try
            load(featurePath);   % --> image
         catch err
             disp(err.identifier());
             return;
         end
         try
            load(encodePath);  % --> idx
         catch err
             disp(err.identifier());
             return;
         end
         % transpose the image.frame matrix
         scaleId = image.frame';
         % the patch size is in the 4th column
         scaleId = scaleId(:,4);
         imgEntropyScale = zeros(1,numel(image.sizes));
         % size(idx,1) == size(scaleId,1) should assert to true
         for j = 1 : numel(image.sizes)
             size_ = image.sizes(j);
             % encoded patches at a given scale
             idxatscale = idx.codeids(scaleId==size_);
             % entropy of patches at a given scale
             % check for empty idxatscale
             
             % entropy of patches at a given scale
             if numel(idxatscale) ~= 0
                ids = vl_binsum(zeros(size(dictionary', 2), 1), 1, double(idxatscale));
                imgEntropyScale(j) = entropy(ids);
             end
             fprintf('%d %d %d %d\n', j, size_, imgEntropyScale(j), entropy(idx.idx));
             
         end
         imageEntropy.entropies = imgEntropyScale;
         imageEntropy.entropy = mean(imgEntropyScale);
         fprintf('%d\t%d\t%d\n', i, expt.testList(i), mean(imgEntropyScale));
         % save to file
         fprintf('%d %s\n',i, expt.testImageEntropyMap(num2str(expt.testList(i))));
         save(expt.testImageEntropyMap(num2str(expt.testList(i))), 'imageEntropy');
    end
end