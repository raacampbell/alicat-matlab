function varargout=MFC_info(AC,MFC,verbose)
% function OUT=MFC-info(AC,MFC,verbose)
%
% Report settings and parameters for a given MFC. 
% Verbose is 1 by default
%
% Rob Campbell - August 28th 2012 - CSHL

if nargin<3
    verbose=1;
end

OUT.MFC=MFC;

if verbose
    fprintf(' *** PARAMETERS FOR MFC #%s ***\n',MFC)
end


%P-gain register 21
fprintf(AC,sprintf('%s$$R21',MFC));
OUT.P=reg2num(fscanf(AC));
if verbose
    fprintf('P gain: %d\n',OUT.P)
end

%D-gain register 22
fprintf(AC,sprintf('%s$$R22',MFC));
OUT.D=reg2num(fscanf(AC));
if verbose
    fprintf('D gain: %d\n',OUT.D)
end


%I-gain register 23
fprintf(AC,sprintf('%s$$R23',MFC));
OUT.I=reg2num(fscanf(AC));
if verbose
    fprintf('I gain: %d\n',OUT.I)
end

if mod(OUT.I,2)
    fprintf('High perfomance mode ENABLED\n')
else
    fprintf('High perfomance mode DISABLED\n')
end


%Closed loop mode
loop=readLoop(AC,MFC);
OUT.loop=loop;
if verbose
    fprintf('Closed loop mode: %s\n',loop)
end



%%%% somewhere I wrote a function that pulled out all the info
% using the 'A??D' stuff. Can't fint it now, though. Hmmm.


if nargout>0
    varargout{1}=OUT;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n=reg2num(in)
n=regexp(in,' = (.*)','tokens');
n=str2double(n{1}{1});