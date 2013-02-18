echo off
git branch
echo "Listing all branches. Make sure you are standing on the right branch you are working on and want to merge (green)"
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

set MERGE=
set /P MERGE=Write in the branch you are working on and want to merge from (green): %=%

set MASTER=
set /P MASTER=Write in the branch you want to merge to (master?): %=%

git checkout %MASTER%
git merge %MERGE%

echo "Merge should now be done"
SET /P ANSWER=Did merge go ok? (Y/N)?
echo You chose: %ANSWER%
if /i {%ANSWER%}=={n} (goto :no)
if /i {%ANSWER%}=={no} (goto :no)
goto :yes
:yes
exit /b 1
:no
git mergetool