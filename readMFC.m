function OUT=readMFC(MFC,quiet)
% Read data from defined Alicat MFC
%
% function OUT=readMFC(MFC,quiet)
%
% Purpose 
% Read data from defined Alicat MFC.
%
% Inputs
% MFC - the string defining which MFC to read fom (e.g. 'A', 'C', etc)
% quiet - optional. true by default.
%
% Rob Campbell - March 20th 2008 - CSHL

% Example of the data format is:
% fprintf(aliConnect,'A10000'); fscanf(aliConnect)
%
%ID; pressure in; temp; vol flow ; mass flow;  set point ; gas
%A +014.61 +023.30 +00.000 +00.000 00.156     Air



global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end

if length(MFC)~=1
    error('Only one MFC should be specified')
end

if nargin<2, quiet=1; end

try
fprintf(aliComm,MFC); %Ping the MFC
IN=fscanf(aliComm); %Read back tthe data
[...
    OUT.ID, ...
    OUT.pressure,...
    OUT.temp,...
    OUT.volumetricFlow,...
    OUT.massFlow,...
    OUT.setPoint,...
    OUT.gas...
    ]=...
    strread(IN,'%s%f%f%f%f%f%s', 'delimiter', ' '); %Format the data


OUT.ID  = cell2mat(OUT.ID) ;
OUT.gas = cell2mat(OUT.gas);
OUT.time = now;

catch
    if ~quiet
    disp('Problem reading from serial port')
    end
    OUT=[];
end
