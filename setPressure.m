function setPressure(MFC,pressure)
% function setPressure(MFC,pressure)
%
% Set a given MFC to maintain a fixed pressure. 
%
% Inputs
% MFC - string specifying the controller ID.
% pressure - desired pressure in PSI (atmospheric by default)
%
% Rob Campbell - June 2010

global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end

if nargin<2
    pressure=14.71;
end

writeLoop(MFC,3);

units=(pressure/160)*64E3;

fprintf(aliComm,[MFC,num2str(round(units))])
fscanf(aliComm);