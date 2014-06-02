function setFlow(flowRate,odourConc)
% function setFlow(flowRate,odourConc)
%
% Set the flow rate of the combined odour stream and the odour
% concentration. Or change flow of just one controller:
%
% flowRate - desired flow rate produced by both controllers (unless
%            odourConc is a controller ID). UNITS: SLPM.
% odourConc- i. maintains the same overall flow rate but changes the odour
%            concentration. UNITS: 0--100% of 1 SLPM 
%            ii. If odourConc is a controller ID (e.g. 'A' or 'B') then the 
%            function sets the named controller to the flow  pecified by 
%            flowRate. Can be a char array of several unit IDs in which
%            case all are set to flowRate.
% examples -
% setFlow(0.5,'A') %Set controler A to half full scale
% setFlow(2100/5000,'C') %Set 5 SLPM controler, C, to 2.1 SLPM
%
% Rob Campbell - 21st March 2008 - CSHL


global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end


if ischar(odourConc)
    
    flowRate=round(flowRate*1000)/1000;
    flowRate=str2double(sprintf('%0.3g',flowRate));
    for i=1:length(odourConc)
        unitID=odourConc(i);
        flow=calcFlow(flowRate);
        fprintf(aliComm, sprintf('%s%d',unitID,flow) )
        A=readMFC(aliComm);
    end

elseif isnumeric(odourConc)
    
    % We will pass 1 SLPM total and allow the odour to from 0 to 100
    % percent of this range.   
    flowA = flowRate*(1-odourConc); % MFC A: clean carrier air stream.
    flowB = flowRate*odourConc;     % MFC B: odourised air stream.
    
    if flowA>1 || flowA<0, error('FlowA out of bounds'), end
    if flowB>1 || flowB<0, error('FlowB out of bounds'), end

    %Convert to correct units for MFC
    flowA=calcFlow(flowA);  flowB=calcFlow(flowB);

    fprintf(aliComm, sprintf('%s%0.0f','A',flowA) )
    fprintf(aliComm, sprintf('%s%0.0f','B',flowB) )
    
end





