echo off
echo "--------------------"
echo "Standing on (green)"
echo "--------------------"
git branch
SET /P ANSWER=Do you want to switch branch (Y/N)?
echo You chose: %ANSWER%
if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)
goto :no
:yes
start cmd /c "SWITCH BRANCH.bat"
timeout -1
:no

git status
echo "Continue with commiting all?"
timeout -1
git add .
set INPUT=
set /P INPUT=Write the commit message explaining whats done: %=%
git commit -am "%INPUT%"
git pull
git push