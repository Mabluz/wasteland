echo off
git branch
echo "Listing all branches. Find the one you want to delete and press enter"
timeout -1
set INPUT=
set /P INPUT=Write in the branch you want to DELETE to (NOTE CAN NOT BE REVERTED): %=%
git checkout master
git branch -d "%INPUT%"
echo "Branch deleted. Now standing on master."