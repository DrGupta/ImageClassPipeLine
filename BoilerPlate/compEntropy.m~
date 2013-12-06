% Compute Entropy of images at multiple scales

function ent = compEntropy(varargin)
ent = 0; % initialize to zero
% ------------------------------------------------------------------------
minarg = 1; % minimum number of input arguments
maxarg = 3; % maximum number of output arguments
% narginchk(minarg,maxarg); % check number of arguments is corrent or throw error

switch nargin
    case 1
        img = varargin{1}; % path to input image
        scale = 1; % default value (original image considered)
        step = 1; % pixel shifts between sample patches default value
    case 2
        img = varargin{1};
        scale = varargin{2};
        step = 1; % default value
    case 3
        img = varargin{1};
        scale = varargin{2};
        step = varargin{3};
    otherwise
        disp('error: input correct arguments');
end
% ------------------------------------------------------------------------

image = imread(img); % load the input image

% ------------------------------------------------------------------------
% compute entropy of image using an interative approach

ent = entropy(image);



return; % return entropy to calling function
end