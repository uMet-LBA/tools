function TOA5_to_TOB1(dir_in,prefix)
% Development : Paulo R. Teixeira
% FeedBack : paulo.ricardo.teixeira at gmail.com
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
% Release Note:
%
% $Revision: 0.2 $
% $Date: 2014/09/12 12:07:48 PM $
%
% Syntax: TOA5_to_TOB1(input_folder,prefix_toa5_files)
%
% Input:    
% {opt}     input_folder             - insert input path
% 
% {opt}     prefix_toa5_files        - insert prefix TOA5 files
%
% Example: TOA5_to_TOB1('/home/user/DATA','TOA5_')

path_bin=[pwd,filesep,'bin',filesep];
tmp_path=[pwd,filesep,'out_tmp',filesep];
cmd='toa_to_tob1.exe';
idir=dir([dir_in,filesep,prefix,'*']);

    if exist(tmp_path, 'dir')
        warning('Directory %s already existing.\n',tmp_path)
        ans = 'Press  Y/N for create directory [Y]: ';
        str = input(ans,'s');
        if isempty(str)
            str = 'Y';
        end
        if strcmpi(str,'Y') == 1

            fprintf('Directory %s created successfully.\n',tmp_path)
            if ~exist(tmp_path, 'dir')
                mkdir(tmp_path);
            end

        else
            fprintf('Bye, bye...\n')
            return
            
        end

    else
        fprintf('Directory %s created successfully.\n',tmp_path)
        mkdir(tmp_path);
    end

    for ifile=1:size(idir,1)
        fprintf('Processing file: %s \n',[idir(ifile).name])
        system([path_bin,cmd,' ',dir_in,idir(ifile).name,' ',tmp_path,'TOB1_',idir(ifile).name]);
    end
end
