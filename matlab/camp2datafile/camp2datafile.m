function camp2datafile(dir_in, varargin)
% INPA - National Institute of Amazonian Research
% LBA  - Large Scale Biosphere-Atmosphere Experiment in Amazonia
%
% Development : Paulo R. Teixeira and Team Micromet.
% FeedBack : paulo.ricardo.teixeira at gmail.com
% last local update : Oct 15,2014
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
% Script to convert raw data file (concatenated)
%
% Release Note:
%
% $Revision: 0.1 $
% $Date: 2014/10/15 05:30 PM $
%
% Syntax: camp_to_datafile(input_folder,prefix_data_files)
%
% Input:
% {opt}     input_folder             - insert input path
%
%
% Example: camp_to_datafile('/home/user/TABLE0')

path_bin=[pwd,filesep,'bin',filesep,'CardConvert',filesep];
tmp_path=[pwd,filesep,'out_tmp',filesep];
exec='CardConvert.exe';
config_file=[pwd,filesep,'config',filesep,'config.ccf'];
%source_path=dir_in;
%target_path=tmp_path;


if nargin == 1
    make_confi_file(dir_in, tmp_path)
    chk_exist_path(tmp_path,0)
    exec_converter(path_bin, tmp_path, exec)
elseif nargin == 2
    for nvarargin=1:length(varargin{1})
        dest_folder=[dir_in,filesep,'TABLE',num2str(varargin{1}(nvarargin)),filesep];
        source_folder_files=[dir_in,filesep,'*TABLE',num2str(varargin{1}(nvarargin)),'*'];
        
        mkdir(dest_folder)
        cmd_copy = sprintf('copy "%s" "%s"', source_folder_files, dest_folder);
        [status, cmdout] = system(cmd_copy);
        
        if status ~= 0
            fprintf('Err!%s\n',cmdout);
        end
        
        dir_in_tables=[tmp_path,'TABLE',num2str(varargin{1}(nvarargin)),filesep];
        make_confi_file(dest_folder, dir_in_tables)
        chk_exist_path(dir_in_tables,0)
        exec_converter(path_bin, dir_in_tables, exec)
        rmdir(dest_folder, 's')
        
    end
    
else
    warning('on','verbose')
    warning('off','backtrace')
    fprintf('Alert! Number of arguments received: %d\n', nargin);
    fprintf('Alert! Number max of arguments equal 2\n');
end

    function make_confi_file(source_path, target_path)
        fprintf('Configuration file created at %s',config_file)
        %%%%% Init config file
        try
            fileID = fopen(config_file, 'w');
            
            if fileID == -1
                error('Err create config file');
            end
            
            fprintf(fileID, '[main]\n');
            fprintf(fileID, 'SourceDir=%s\n', source_path);
            fprintf(fileID, 'TargetDir=%s\n', target_path);
            fprintf(fileID, 'Format=2\n');
            fprintf(fileID, 'FileMarks=1\n');
            fprintf(fileID, 'RemoveMarks=0\n');
            fprintf(fileID, 'RecNums=1\n');
            fprintf(fileID, 'Timestamps=1\n');
            fprintf(fileID, 'CreateNew=0\n');
            fprintf(fileID, 'DateTimeNames=1\n');
            fprintf(fileID, 'Midnight24=1\n');
            fprintf(fileID, 'ColWidth=755\n');
            fprintf(fileID, 'ListHeight=535\n');
            fprintf(fileID, 'ListWidth=190\n');
            fprintf(fileID, 'BaleCheck=1\n');
            fprintf(fileID, 'CSVOptions=66015\n');
            fprintf(fileID, 'BaleStart=38718\n');
            fprintf(fileID, 'BaleInterval=32874,0416666667\n');
            fprintf(fileID, 'DOY=0\n');
            fprintf(fileID, 'Append=1\n');
            fprintf(fileID, 'ConvertNew=0\n');
            
            fclose(fileID);
            fprintf('Configfile %s created successfully.\n', config_file);
            
        catch ME
            warning('Fail! %s', ME.message);
        end
        %%%%% End config file
    end

    function chk_exist_path(target_path,verbose)
        if verbose == 1
            warning('on','verbose')
            warning('off','backtrace')
        end
        if exist(target_path, 'dir')
            warning('off','backtrace')
            warning('Directory %s already existing.\n',target_path)
            ans = 'Press  Y/N for create directory [Y]: ';
            str = input(ans,'s');
            if isempty(str)
                str = 'Y';
            end
            if strcmpi(str,'Y') == 1
                fprintf('Directory %s created successfully.\n' ,target_path)
                if ~exist(target_path, 'dir')
                    mkdir(target_path);
                end
            else
                fprintf('Bye, bye...\n')
                return
            end
        else
            mkdir(target_path);
            fprintf('Directory %s created successfully.\n',target_path)
        end
        %%%%% End chk path
    end

    function exec_converter(path_bin,target_path,exec)
        cmd_exec = sprintf('%s runfile="%s"', [path_bin,filesep,exec], config_file);
        fprintf('Starting...\n');
        [status, cmdOut] = system(cmd_exec);
        if status == 0
            fprintf('Successfully! Files in %s\n',target_path);
        else
            fprintf('Fail!\n');
            disp(cmdOut);
        end
    end
end