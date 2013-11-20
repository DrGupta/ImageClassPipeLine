function [config, expt] = overture()

clear; % clear memory of previous variables with erroneous data

config = getIniData('config.ini'); % get expt config for paths

expt = struct(); % create an empty expt object for data during the expt run

% to log the experiment run record the data and time
expt.date = date(); 
expt.time = num2str(now);

end
