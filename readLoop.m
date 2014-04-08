function varargout=readLoop(AC,MFC)
% function loop=readLoop(AC,MFC)
%
% Query the loop mode of an MFC
% 
% Inputs
% AC - serial port object 
% MFC - string specifying the controller ID
%
% Outputs
% loop - string giving the loop type. If no output arg then 
% just print to screen. 
%
% Rob Campbell June 2010


fprintf(AC,[MFC,'$$R20']);
F=fscanf(AC);


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

