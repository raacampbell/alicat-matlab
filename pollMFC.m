function out=pollMFC(ID,rate,samples)
% Poll Alicat MFC at regular interval
%
% function out=pollMFC(AC,ID,rate,samples)
%
% Purpose
% Poll Alicat MFC "ID" every "rate" seconds, obtaining
% "samples" number of data points. 
%
% Inputs
% ID - unit ID to sample
% rate - scaler defining how often to record. e.g. a rate of 0.2
%        will obtain 5 sample a second. 
% samples - how many samples to obtain
%
%
% Rob Campbell - June 2010

%Connect to MFC serial port
global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end


rateLimit=0.05;  
if rate<rateLimit
  fprintf('Desired rate is too fast, setting rate to %f\n',...
          rateLimit)
end


for ii=1:samples
  fprintf(aliComm,ID); %Triggers the MFC identified by the string "ID" so it generates a data report
  out(ii)=readMFC(aliComm);
  pause(rate)
end

  
