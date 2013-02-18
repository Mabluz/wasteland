echo off
git status
echo "Continue with commiting all?"
timeout -1
git add .
set INPUT=
set /P INPUT=Write the commit message explaining whats done: %=%
git commit -am "%INPUT%"
git pull
git push