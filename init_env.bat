@echo off
set PATH=%PATH%;C:\Program Files\nodejs
echo Node: 
node -v
echo NPM:
npm.cmd -v
echo NPX:
npx.cmd -v

echo Initializing npm...
call npm.cmd init -y
echo Installing local dependencies...
call npm.cmd install xlsx
