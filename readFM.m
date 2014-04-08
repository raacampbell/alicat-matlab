function OUT=readFM(aliComm)
% function OUT=readFM(aliComm)
%
% Read data from the Alicat flow meter
%
% Rob Campbell - June 14th 2010 - CSHL

% Example of the data format is:
% fprintf(aliConnect,'G'); fscanf(aliConnect)
%
%ID; pressure in; temp; volumetric flow; mass flow; gas
%A +014.61 +023.30 +00.000 +00.000 00.156     Air

try
    
IN=fscanf(aliComm);
[...
    OUT.ID, ...
    OUT.pressure,...
    OUT.temp,...
    OUT.volumetricFlow,...
    OUT.massFlow,...
    OUT.gas...
    ]=...
    strread(IN,'%s%f%f%f%f%s', 'delimiter', ' ');


OUT.ID  = cell2mat(OUT.ID) ;
OUT.gas = cell2mat(OUT.gas);
OUT.time=now;

catch
    disp('Problem reading from serial port')
    OUT=[];
end
