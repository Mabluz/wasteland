echo off
git branch
echo "Listing all branches. Make sure you are standing on the right branch you are working on (green)"
timeout -1
git status
SET /P ANSWER=Do you have anything to commit before merging (Y/N)?
echo You chose: %ANSWER%
if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)
goto :no
:yes
start cmd /c "COMMIT ALL WORK TO GIT.bat"
timeout -1
:no


set INPUT=
set /P INPUT=Write in the branch you want to merge: %=%
#git checkout "%INPUT%"
#echo "Branch switched. Do you want to get latest files? If not close window."
timeout -1
#git pull