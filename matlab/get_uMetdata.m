function [datasetOut] = get_uMetdata(type)
% get_uMetdata is part of  Flow uMet-LBA Qa/Qc system Toolbox
% INPA - National Institute of Amazonian Research
% LBA  - Large Scale Biosphere-Atmosphere Experiment in Amazonia
%
% Development : Paulo R. Teixeira
% FeedBack : paulo.ricardo.teixeira at gmail.com
%
% Syntax: get_uMetdata(type)
%
% Input:    
% {type}     insert type dataset # not case sensitive 
%
% Example: get_uMetdata('Meteo') # Meteo dataset
%          get_uMetdata('Solo')  # Soil dataset
%
% $Revision: 0.1.0 $ $Date: 2019/04/22 15:51:00 $
%
% This computer script  (M file) is distributed in the hope that it will
% be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, please download it from
% <http://www.gnu.org/licenses>
lic('y')
tic;
data = getMydata(type);
datasetOut=loadData(data);
t=toc;
fprintf(' Elapsed Time: %s \n\n\n:',...
    datestr(datenum(0,0,0,0,0,t),'HH:MM:SS'))
end
function [idataset] = getMydata(type)
options = weboptions('RequestMethod','auto','ContentType','auto');
switch lower(type)
    case {'meteo'}
        fprintf(' Downloading dataset ...[Meteo%s.csv]\n\n',char(tstamp));
        fullURL = [buffURL(1)];
        idataset = websave(['Meteo_',char(tstamp),'.csv'],fullURL);
        fprintf('\n');
    case {'solo'}
        fprintf(' Downloading dataset ...[Solo%s.csv]\n\n',char(tstamp));
        fullURL = [buffURL(2)];
        idataset = websave(['Solo_',char(tstamp),'.csv'],fullURL);
        fprintf('\n');
    otherwise
        error([mfilename ':ErrorType'],...
            'Unknown type dataset');
end
end
function t=tstamp
t=datetime(datetime,'Format','yyyyMMddHHmmss','convertFrom','datenum');
end
function aux_dataset=loadData(data)
aux=importdata(data);
ctime=datevec(aux.textdata);
aux_dataset=[ctime(:,1:end-1) aux.data];
end
function lic(YN)
switch lower(YN)
    case {'y'}
        clc;
        fprintf('\n\n\n This %s computer script is distributed in the hope that it will \n',upper(mfilename));
        fprintf(' be useful, but WITHOUT ANY WARRANTY; without even the implied warranty\n');
        fprintf(' of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n');
        fprintf(' GNU General Public License for more details.\n');
        fprintf('\n');
        fprintf(' You should have received a copy of the GNU General Public License\n');
        fprintf(' along with this program; if not, please download it from\n');
        fprintf(' <http://www.gnu.org/licenses>\n\n');
        pause(0.1)
        fprintf('\n');
    case {'n'}
        fprintf('\n');
    otherwise
        error([mfilename ':ErrorType'],...
            'Unknown type');
end
end
function url=buffURL(itype)
iurl={'https://*******';'https://*******'};
url=iurl{itype};
end
