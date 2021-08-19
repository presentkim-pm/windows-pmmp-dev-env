@echo off
TITLE Pocketmine-MP

:loop
    IF EXIST PocketMine-MP.phar (
        bin\php\php.exe -c bin\php PocketMine-MP.phar
    ) ELSE (
        ECHO YOU NEED INSTALL PMMP.
    )
    pause
goto loop