classdef ExptConfig < handle
    % experiment configuration object
    
    % Dataset Properties
    properties
        dataSetName;                        % string = 'DPchallenge'
        numClass;                           % double = 2
        numImageTraining;                   % double = 3000
        numImageTesting;                    % double = 3000
        permutation;                        % boolean = false        
    end
    
    % Algorithm Properties
    properties
        spatialPyramid;                     % boolean = false
        pyramidLevel;                       % double = 3
        svm;                                % boolean = true
        feature;                            % string = 'phow'
        featSize;                           % array = [4,8,16,32]
        featStep;                           % double = 4
        featColor;                          % string = 'rgb'
        extractFeatures;                    % boolean = true
    end
    
    % Coding Properties
    properties
        trainCodeBook;                      % boolean = true
        codeNum;                            % double = 1000
        clustering;                         % string = 'kmeans'
        downsample;                         % double = 3
    end
    
    % Constructor
    methods (Access = public)
        % Default Constructor
        function self = ExptConfig(varargin)
            if nargin == 0
                % dataset
                self.dataSetName = 'DPchallenge';
                self.numClass = 2;
                self.numImageTraining = 100;
                self.numImageTesting = 100;
                self.permutation = false;
                % algorithm
                self.spatialPyramid = true;
                self.pyramidLevel = 3;
                self.svm = true;
                %self.feature = 'phow';
                self.feature = 'phow';
                self.featSize = [8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128,136,144,152,160];
                self.featStep = 8;
                self.featColor = 'rgb';
                self.extractFeatures = true;
                % coding
                self.trainCodeBook = true;
                self.codeNum = 100;
                self.clustering = 'kmeans';
                self.downsample = 3;
            elseif nargin == 1
                % Constructor using configuration initialization file
                self = ExptConfig();
                configFileName = varargin{1};
                self = readExptConfig(self, configFileName);
            end
        end
        
    end
    
    methods (Access = private)
        % Reads the configuration file and updates the ExptConfig object
        % --- Matlab does not allow overloading the constructor ---
        function self = readExptConfig(self, configFileName)
            config = readconfig(configFileName);
            fieldNames = fieldnames(config);
            nFieldNames = size(fieldNames,1);
            for i = 1 : nFieldNames
                switch fieldNames{i}
                    % --- DEBUG ---
                    
                    % -------------
                    case 'DATASETNAME'
                        self.dataSetName = config.DATASETNAME;
                    case 'NUMCLASS'
                        self.numClass = config.NUMCLASS;
                    case 'NUMIMAGETRAINING'
                        self.numImageTraining = config.NUMIMAGETRAINING;
                    case 'NUMIMAGETESTING'
                        self.numImageTesting = config.NUMIMAGETESTING;
                    case 'PERMUTATION'
                        self.permutation = config.PERMUTATION;
                    case 'SPATIALPYRAMID'
                        self.spatialPyramid = config.SPATIALPYRAMID;
                    case 'PYRAMIDLEVEL'
                        self.pyramidLevel = config.PYRAMIDLEVEL;
                    case 'SVM'
                        self.svm = config.SVM;
                    case 'FEATURE'
                        self.feature = config.FEATURE;
                    case 'FEATSIZE'
                        self.featSize = config.FEATSIZE;
                    case 'FEATSTEP'
                        self.featStep = config.FEATSTEP;
                    case 'FEATCOLOR'
                        self.featColor = config.FEATCOLOR;
                    case 'TRAINCODEBOOK'
                        self.trainCodeBook = config.TRAINCODEBOOK;
                    case 'CODENUM'
                        self.codeNum = config.CODENUM;
                    case 'CLUSTERING'
                        self.clustering = config.CLUSTERING;
                    case 'DOWNSAMPLE'
                        self.downsample = config.DOWNSAMPLE;
                    case 'EXTRACTFEATURES'
                        self.extractFeatures = config.EXTRACTFEATURES;
                    otherwise
                        fprintf('%s : %s',fieldNames{i}, 'unrecognized');
                end
            end
        end
    end
end