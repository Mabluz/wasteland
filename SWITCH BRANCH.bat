echo off
git branch
echo "Listing all branches."
set INPUT=
set /P INPUT=Write in the branch you want to switch to: %=%
git checkout "%INPUT%"
git pull
echo "Branch switched"
timeout 10