function createFileLists(config,expt)
% ----------------------------------------------------------







% ----------------------------------------------------------

nClass = str2double(config.dataset.nClass); % number of classes or categories

count = 1;
if(~strcmp(config.dataset.training_dir,''))
    nImgPerClass=str2double(config.dataset.nImgPerClass_training);
    trPath = [config.dataset.training_dir,'/images/'];
    filelist_training = cell(nClass*nImgPerClass,3);
    for iClass = 1:nClass
        classPath = [trPath,num2str(iClass),'/'];
        listing = dir(classPath);
        listing = listing(3:end);%discard '.' and '..'
        for fileNo = 1:nImgPerClass
            name = listing(fileNo).name;
            fullPath = [classPath,name];
            filelist_training(count,:)  = [{fullPath},{iClass},{fileNo}];
            count = count+1;
        end
    end
    save('training_list.mat','filelist_training'); % write to file
    expt.filelist_training = filelist_training; % save in 'expt' struct
end


clear filelist
count = 1;
if(~strcmp(config.dataset.training_dir,''))
    nImgPerClass=str2double(config.dataset.nImgPerClass_testing);
    testPath = [config.dataset.testing_dir,'/images/'];
    filelist_testing = cell(nClass*nImgPerClass,3);
    for iClass = 1:nClass
        classPath = [testPath,num2str(iClass),'/'];
        listing = dir(classPath);
        listing = listing(3:end);%discard '.' and '..'
        for fileNo = 1:nImgPerClass
            name = listing(fileNo).name;
            fullPath = [classPath,name];
            filelist_testing(count,:)  = [{fullPath},{iClass},{fileNo}];
            count = count+1;
        end
        
    end
    save('testing_list.mat','filelist_testing'); % write to file
    expt.filelist_testing = filelist_testing; % save in 'expt' struct
end

if(strcmp(config.dataset.permutation,'true'))
    order = randperm(size(filelist_testing,1));
    filelist_perm = filelist_testing(order,:);
    groundTruth = cell2mat(filelist_perm(:,2));
    save('perm_list.mat','filelist_perm');          % write to file
    save('accuracy/groundTruth.mat','groundTruth'); % write to file
    
    expt.filelist_perm = filelist_perm;             % write to 'expt' struct
    expt.groundTruth = groundTruth;
    
end

end