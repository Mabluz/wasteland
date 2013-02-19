echo off
git branch
echo "Listing all branches that allready exists."
set INPUT=
set /P INPUT=Write in the name of the new branch you want create: %=%
git checkout Master
git pull
git checkout -b "%INPUT%"
git branch
echo ""
echo "Branch created and switched"
timeout 10