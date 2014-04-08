function aliComm=connectAlicat(COM)
% function aliComm=connectAlicat(COM)
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


if nargin==0
    COM='COM3';
end

%    global aliComm

aliComm=serial(COM,...
        'TimeOut', 2,...
        'BaudRate', 19200,...
        'Terminator','CR');

fopen(aliComm)
