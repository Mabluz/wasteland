echo off
git branch
echo "Listing all branches. Find the one you want to delete and press enter"
timeout -1
set INPUT=
set /P INPUT=Write in the branch you want to DELETE to (NOTE CAN NOT BE REVERTED): %=%
git checkout "%INPUT%"
git status
SET /P ANSWER=Do you have anything on the branch that is not checked in or merged to master? (Y/N)?
echo You chose: %ANSWER%
if /i {%ANSWER%}=={n} (goto :no)
if /i {%ANSWER%}=={no} (goto :no)
goto :yes
:yes
start cmd /c "MERGE CURRENT BRANCH WITH MASTER.bat"
exit
:no
echo "Press enter to delete branch"
timeout -1
git checkout master
git branch -d "%INPUT%"
echo "Branch deleted. Now standing on master."
timeout -1