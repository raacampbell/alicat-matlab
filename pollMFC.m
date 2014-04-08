function out=pollMFC(AC,ID,rate,samples)
% function out=pollMFC(AC,ID,rate,samples)
%
% Poll Alicat MFC "ID" every "rate" seconds, obtaining
% "samples" number of data points. 
%
% Inputs
% AC - serial port object
% ID - unit ID to sample
% rate - scaler defining how often to record. e.g. a rate of 0.2
%        will obtain 5 sample a second. 
% samples - how many samples to obtain
%
%
% Rob Campbell - June 2010
rateLimit=0.05;  
if rate<rateLimit
  fprintf('Desired rate is too fast, setting rate to %f\n',...
          rateLimit)
end


for ii=1:samples
  fprintf(AC,ID);
  out(ii)=readMFC(AC);
  pause(rate)
end

  
