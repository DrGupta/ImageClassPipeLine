function R = readconfig(configfile)
% ------------------------------------------------------------------------
% Read configuration file
% ------------------------------------------------------------------------

% default configuration file is : 'config.ini'
if nargin<1, 
   configfile = 'config.ini';
end;

% open the configuration file
fid = fopen(configfile);

if fid < 0
    error('cannot open file %s\n',a); 
end

% parse the configuration file line by line 
while ~feof(fid)
   % read line (ignoring the leading and trailing white space
   line = strtrim(fgetl(fid));
    
   % ignore line if it is empty, all spaces, or contains a comment prefix
   % '#' or ';'
   if isempty(line) || all(isspace(line)) || strncmp(line,'#',1) || strncmp(line,';',1),
       % no operation 
   else
       % split the line by a 'tab' or '='
       tokens = regexp(line,'=','split');
   var = upper(strtrim(tokens{1})); % the parameter is the fist token
   % if a , exists in the token, split the string into mulitple tokens
   tok = tokens{2};
   if any(tok==',')
            k = 1; 
        while (1)
            [val, tok]=strtok(tok,',');
            % return value of function 
            R.(var){k} = strtrim(val);  	
            % stores variable in local workspace
            eval(sprintf('%s{%i}=''%s'';',var,k,strtrim(val)));
            % if the token string is empty, then quit the loop, otherwise move
            % to the next element of the token string
            if isempty(tok) 
                break; 
            end
            k=k+1;
        end
   else
        % strip the whitespace away from the token string
        tok = strtrim(tok);
        % return value of function
        R.(var) = tok;
        % stores variable in local workspace
        eval(sprintf('%s=''%s''; ',var,tok));  
    end;
    end;
end; 
fclose(fid);

% -------------------------------------------------------------
% DEBUG
% -------------------------------------------------------------
% shows the parameter in the local workspace 
whos
% -------------------------------------------------------------