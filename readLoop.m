function varargout=readLoop(MFC)
% function loop=readLoop(MFC)
%
% Query the loop mode of an MFC
% 
% Inputs
% MFC - string specifying the controller ID
%
% Outputs
% loop - string giving the loop type. If no output arg then 
% just print to screen. 
%
%
% Example
% L=readLoop('B')
%
%
% Rob Campbell June 2010



global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end

fprintf(aliComm,[MFC,'$$R20']);
F=fscanf(aliComm);


loop=regexp(F,'= (.*)','tokens');
loop=str2num(loop{1}{1});

%9460 is mass flow (For the 1 and 5 SLPM controllers)
%9238 is mass flow (For the 0.5 SLPM controllers)
mass=[9238,9460];

volumetric=mass-2^10+768;
pressure=mass-2^10+256;

switch loop
    case {volumetric(1),volumetric(2)}
        L='volumetric';
    case {mass(1),mass(2)}
        L='mass';
    case {pressure(1),pressure(2)}
        L='pressure';
end


if nargout==0
    fprintf('%s\n',L)
end

if nargout>0
    varargout{1}=L;
end

if nargout>1
    varargout{2}=loop;
end

