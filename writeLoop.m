function varargout=writeLoop(MFC,loop)
% function loop=writeLoop(AMFC,loop)
%
% Set the loop mode of an MFC
% 
% Inputs
% MFC - string specifying the controller ID
% loop - a scalar. 1 for mass, 2 for volume, 3 for pressure. 
%
% Outputs
% loop - [optional] string confirming the new loop type. 
%
% Rob Campbell June 2010


global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end


setFlow(0,MFC) %Make sure we're zero before doing anything


%Different units have different register values for different loop types.
%So we need to get the right ones:

mass=[9238,9460];
vol=mass-2^10+768;
press=mass-2^10+256;

loops=[mass;...
       vol;...
       press];
   
[~,L]=readLoop(MFC);
L=loops(:,any(loops==L));


fprintf(aliComm,[MFC,'$$W20=',num2str(L(loop))]);
fscanf(aliComm);

if nargout==1
    varargout{1}=readLoop(MFC);    
end
