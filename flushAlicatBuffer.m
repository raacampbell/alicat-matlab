function flushAlicatBuffer
% function aliComm=connectAlicat
%
% Keep reading from the buffer until there are no more data. 
%
% Rob Campbell - 1st Feb 2013 - CSHL




global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end

fprintf('Flushing Alicat serial buffer')
while aliComm.BytesAvailable>0
    fread(aliComm,aliComm.BytesAvailable);
    fprintf('.')
    pause(0.05)
end
fprintf('\n')