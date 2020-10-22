@echo off
TITLE Pocketmine-MP in Windows 10

set PHP_PATH=bin\php
set PHP_BINARY=%PHP_PATH%\php.exe
set POCKETMINE_FILE=PocketMine-MP.phar


:loop
    %PHP_BINARY% -c %PHP_PATH% %POCKETMINE_FILE%
    pause
goto loop