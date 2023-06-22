REM get_DataCollect_GHGFiles is part of uMet-LBA system Toolbox
@echo off
REM INPA - National Institute of Amazonian Research
REM LBA  - Large Scale Biosphere-Atmosphere Experiment in Amazonia
REM
REM Development : Paulo R. Teixeira @20230622
REM FeedBack : paulo.ricardo.teixeira at gmail.com
REM
REM This computer batch script is distributed in the hope that it will
REM be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with this program; if not, please download it from
REM <http://www.gnu.org/licenses>
REM
REM Add WinSCP on system environment variable PATH 
PATH %PATH%;C:\Program Files (x86)\WinSCP
REM config. variables
set timestamp=%date:~-4,4%%date:~-7,2%%date:~-10,2%T%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%
set logFileName=LicorGHG_DataCollect
set hostIP=10.16.41.146
set username=licor
set password=licor
set src_path=home/licor/data/raw
set root_path=C:\Temp
set out_path=%root_path%\%date:~-4,4%%date:~-7,2%%date:~-10,2%
set hostkey=ssh-rsa 2048 lH2Szh1SsVMyuyP/owqxPUMXG4Qi3ugvhBIUHhz0CEQ
set logfile=%logFileName%-%timestamp%.log

echo Script started %timestamp%

if EXIST %out_path% (
   echo ERROR: Output folder found! >> %logfile% & exit
)

if NOT EXIST %out_path% (
   mkdir %out_path%
   echo WARNING: new archive folder created
   cd %out_path%
   echo INFO: *** Summary ***
   echo INFO: Using source folder %src_path%
   echo INFO: Using output folder %out_path%
   echo INFO: Connecting on %hostIP%
)

winscp.com /ini=nul /log=%logfile% /command ^
    "open sftp://%username%:%password%@%hostIP%/%src_path%/%date:~6,4%/%date:~3,2%/ -hostkey=""%hostkey%""" ^
    "get %date:~-4,4%-%date:~-7,2%-%date:~-10,2%*.ghg" ^
    "close" ^
    "exit"

echo INFO: data downloads are finished.  >> %logfile% & exit
