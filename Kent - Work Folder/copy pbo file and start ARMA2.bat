echo off
set pboFile=E:\Downloads\"Arma2 Mods"\wasteland\ArmaFiles\Wasteland_United_Chernarus.Chernarus.pbo
set missionFolder=C:\"Program Files (x86)"\Steam\steamapps\common\"Arma 2 Operation Arrowhead"\MPMissions\
set arma=C:\"Program Files (x86)"\Steam\steamapps\common\"Arma 2 Operation Arrowhead"\arma2oa.exe


taskkill /f /im arma2oaserver.exe 
timeout 10

taskkill /f /im arma2oa.exe
timeout 10

xcopy /y %pboFile% %missionFolder%

#echo "Press enter when ready to start ARMA2"
timeout -1

#start %arma% -nosplash -skipIntro -world=empty