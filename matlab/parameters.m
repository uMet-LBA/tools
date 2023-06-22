% parameters is part of  Flow uMet-LBA Qa/Qc system Toolbox
% INPA - National Institute of Amazonian Research
% LBA  - Large Scale Biosphere-Atmosphere Experiment in Amazonia
%
% Development : Paulo R. Teixeira and Team Micromet.
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
% Parameters for reads numeric and delimited file (type ASCII).
% The comma is set as the default delimiter. When the parameter
% is not defined the delimiter is inferred from the formatting of the file.
%

params.delimiter_value = ',';

params.input_path = {'C:\Users\paulo\Downloads'};
params.input_filename = {'TMA_meteo_1min_2019_BRUTO_PRE_gaps'};
params.input_extension = {'csv'};

params.output_path = {'C:\Users\paulo\Downloads'};
params.output_filename = {'output_TMA_1min'};
params.output_extension = {'csv'};
