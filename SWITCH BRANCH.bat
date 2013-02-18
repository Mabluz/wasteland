echo off
git branch
echo "Listing all branches. Press enter to switch branch"
timeout -1
set INPUT=
set /P INPUT=Write in the branch you want to switch to: %=%
git checkout "%INPUT%"
echo "Branch switched. Do you want to get latest files? If not close window."
timeout -1
git pull