function flushAlicatBuffer(AC)
% function aliComm=connectAlicat(AC)
%
% Keep reading from the buffer until there are no more data. 
%
% Rob Campbell - 1st Feb 2013 - CSHL

while AC.BytesAvailable>0
    fread(AC,AC.BytesAvailable);
    pause(0.05)
end
