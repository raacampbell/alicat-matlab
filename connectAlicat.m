function aliComm=connectAlicat
% function aliComm=connectAlicat
%
% * Purpose
% Form a connection to the Alicat controller. By default 
% connects to COM port hard-coded into file. User may overide
% this.
% 
% * Example:
% Connecting to port 4:
% AC=connectAlicat('COM3');
%
% Rob Campbell - 20th March 2008 - CSHL


%Edit following line for your comm port!
COM='COM3';

fprintf('Connecting to Alicats on port %s\n',COM)

aliComm=serial(COM,...
        'TimeOut', 2,...
        'BaudRate', 19200,...
        'Terminator','CR');

fopen(aliComm)
