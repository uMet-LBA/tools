% timesync is part of  Flow uMet-LBA Qa/Qc system Toolbox
% INPA - National Institute of Amazonian Research
% LBA  - Large Scale Biosphere-Atmosphere Experiment in Amazonia
%
% Development : Paulo R. Teixeira and Team Micromet.
% FeedBack : paulo.ricardo.teixeira at gmail.com
% last local update : May 26,2023
%
% This computer script (M file) is distributed in the hope that it will
% be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, please download it from
% <http://www.gnu.org/licenses>
%
% Script to checking time gap data from SAF-Dende, Moju and K34 tower
%
% All data in the input file must be numeric. dlmread does not operate
% on files containing nonnumeric data, even if the specified rows and
% columns for the read contain numeric data only.
%

tic;
clear all; clc;%#ok

try
    parameters
catch err
    error([mfilename ':ErrorRunFile'],'Could not run parameters file');
end

try
data = dlmread([params.input_path{1}, filesep,...
    params.input_filename{1}, '.',...
    params.input_extension{1}], params.delimiter_value);%#ok
catch err
    error([mfilename ':ErrorOpenFile'],'Could not open data file');
end

time_step = min(diff(unique(data(:,4))));

fprintf(' Configuration summary\n %s\n',repmat('*', 1, 21))
fprintf(' Input path: %s\n Input file: %s\n',params.input_path{1},...
    [params.input_filename{1},'.',params.input_extension{1}])
fprintf(' Output path: %s\n Output file: %s\n\n',params.output_path{1},...
    [params.output_filename{1},'.',params.output_extension{1}])

if time_step == 1 || time_step == 10 || time_step == 30
    fprintf(' Time Step condition Okay!\n')
    if time_step == 1
        time_step_end = 59;
    else
        time_step_end = 50;
    end

else
    fprintf(' Error! Fail Time Step increment.\n\n\nExit code!\n')
    return
end

time = [];
for i = 0:23
    time = [time;[i*100+[0:time_step:time_step_end]]']; %#ok
end
time(time == 0,:) = 2400;time = (sort(time));
data_sync = [];
id_value = unique(data(:,1));
year = unique(data(:,2));
if size(id_value,1) ~= 1 || size(year,1) ~= 1
    fprintf(' Error! Fail id or year value.\n\n\nExit code!\n')
    return 
end
for day = min(data(:,3)):max(data(:,3))
    id = find(data(:,3) == day);
    if isempty(id) == 1
        data_sync = [data_sync;id_value*ones(size(time,1),1) ...
            year*ones(size(time,1),1) day*ones(size(time,1),1) time ...
            nan(size(time,1),size(data,2)-4)];%#ok
    else
        aux_day = data(id,:);
    	for it = 1:size(time,1)
          	t = time(it,1);
    		idt = find (aux_day(:,4) == t);
            if isempty(idt) == 1
                data_sync = [data_sync;...
                    id_value year day t nan(1,size(data,2)-4)];%#ok
            else
                data_sync =	[data_sync;aux_day(idt,:)];%#ok
            end

    	end

    end
end

try
    fprintf(' Writing output data file.\n')
    dlmwrite([params.output_path{1}, filesep,...
    params.output_filename{1}, '.', params.output_extension{1}],...
    data_sync)%#ok
catch err
    error([mfilename ':ErrorOpenFile'],'Could not write data ouput file');  % msg de erro
end
t=toc;
fprintf(' Elapsed Time: %s \n\n\n',...
    datestr(datenum(0,0,0,0,0,t),'HH:MM:SS'))%#ok
