function expt = encodeImage(expt, config, imageID, count)

    if strcmp(expt.phase, 'training')
        featurePath = expt.trainImageFeatureMap(num2str(imageID));
        try
            load(featurePath, 'image');
        catch err
            disp(err.identifier());
            return;
        end
        % image structure has the descriptors
        descrs = image.descrs;
        % transpose the descriptor matrix
        descrs = double(descrs');
        dictionary = expt.codeBook;
        disp(size(dictionary'));
        disp(size(descrs'));

        [~, codeids] = min(vl_alldist(dictionary', descrs'), [], 1);
        
        ids = vl_binsum(zeros(size(dictionary', 2), 1), 1, double(codeids));
        ids = double(ids);
        idx.codeids = codeids;
        idx.idx = ids;

        fprintf('%d %d %d\n', count, imageID, entropy(ids) );
        % save the encoded descriptor patches to file                    
        save(expt.trainImageEncodedMap(num2str(imageID)), 'idx');
    elseif strcmp(expt.phase, 'testing')
        featurePath = expt.testImageFeatureMap(num2str(imageID));
        try
            load(featurePath, 'image');
        catch err
            disp(err.identifier());
            return;
        end
        % image structure has the descriptors
        descrs = image.descrs;
        % transpose the descriptor matrix
        descrs = double(descrs');
        dictionary = expt.codeBook;

        [~, codeids] = min(vl_alldist(dictionary', descrs'), [], 1);
        ids = vl_binsum(zeros(size(dictionary', 2), 1), 1, double(codeids));
        ids = double(ids);
        idx.codeids = codeids;
        idx.idx = ids;

        fprintf('%d %d %d\n', count, imageID, entropy(ids) );
        % save the encoded descriptor patches to file                    
        save(expt.testImageEncodedMap(num2str(imageID)), 'idx');
    end

end
