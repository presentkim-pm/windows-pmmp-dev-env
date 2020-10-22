@echo off
TITLE Pocketmine-MP Update

set DOWNLOAD_URL="https://jenkins.pmmp.io/job/PocketMine-MP/lastSuccessfulBuild/artifact/PocketMine-MP.phar"
set POCKETMINE_FILE=PocketMine-MP.phar

echo Pocketmine-MP Update start...
echo.
echo --------------------------------------------------------------------------------
curl  %DOWNLOAD_URL% -o %POCKETMINE_FILE%
echo --------------------------------------------------------------------------------
echo Update done.
echo.
pause