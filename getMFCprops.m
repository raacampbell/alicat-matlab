function varargout=getMFCprops(AC,unit,prop)
% Read properties of the MFC
%
% function props=getMFCprops(AC,unit,prop)
%
% Purpose
% Read the properties of the Alicat MFC identified by the character
% "unit". If "prop" is not defined then all properties are printed to
% the screen (optionally a structure is returned). Properties on this
% list are numbered (e.g. the first is "D01"). These are returned in
% the structure "props". Returning all is quite slow, so to return a
% specific one, the third input argument must be supplied. For
% example, to get back the volumetric flow information do:
% getMFCprops(AC,unit,4) %does not print data to screen
%
% Inputs
% AC - serial port object associated with the MFCs.
% units - single character denoting the MFC we want to poll
% prop - [optional] index of the propery we wish to extract. 
%
% Outputs
% props - structure containing the polled information
%
% Rob Campbell - February 2012, JFRC
  


if nargin<3
  prop=0;
end


if prop==0

  n=1;
  fprintf(AC,sprintf('%s??D*',unit));
  
  for ii=1:21
    str=fscanf(AC);
    fprintf('%s',str)
    if ii>1
      props(n)=readProps(str);
      n=n+1;
      end
  end
  
else
  
  fprintf(AC,sprintf('%s??D%d',unit,prop));
  str=fscanf(AC)
  props=readProps(str);
  
end




if nargout>0  
  %Reformat so the field names become incorporated into a new
  %structure of length one. 
  
  tmp.id = props(1).id;
  for ii=1:length(props)
    name=(lower(props(ii).name));
    tmp.(name).min = props(ii).min;
    tmp.(name).max = props(ii).max;
    tmp.(name).units = props(ii).units;  
  end
  varargout{1}=tmp;
end


%----------------------------------------------------------------------
function out=readProps(str)
  
  [out.id,~,out.name,T,out.min,out.max,out.units]=...
      strread(str,repmat('%s ',1,7));

  %for some reason these come out as cell arrays. So:
  F=fields(out);
  for ii=1:length(F)
    out.(F{ii})=cell2mat(out.(F{ii}));
  end
  
  
  
  if strcmp(T,'signed') | strcmp(T,'signed')
    out.min=str2double(out.min);
    out.max=str2double(out.max);
  end
  

  %The large MFCs return their units in (S)LPM and the smaller in
  %(S)CCM. It's going to be easier if both large and small units
  %return the same units. We'll choose CCM. So we must multiply
  %LPM units by 1000 if appropriate. 
  if ~isempty(strfind(out.units,'LPM'))
    out.units=strrep(out.units,'LPM','CCM');
    out.min=out.min*1000;
    out.max=out.max*1000;
  end
