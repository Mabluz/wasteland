echo off
git branch
echo "Listing all branches that allready exists. Press enter to create"
timeout -1
set INPUT=
set /P INPUT=Write in the branch you want create: %=%
git checkout Master
git pull
git checkout -b "%INPUT%"
echo "Branch created and switched"