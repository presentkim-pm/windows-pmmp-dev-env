@ECHO OFF
cd /d %~dp0

IF [%1]==[] (set CHANNEL=stable) ELSE (set CHANNEL=%1)
TITLE Pocketmine-MP Install (%CHANNEL%)

set BASE_DIR=%cd%
set BIN_DIR=%BASE_DIR%\bin
set PHP_DIR=%BIN_DIR%\php
set PMMP_DIR=%BIN_DIR%\pmmp
set PHP=%PHP_DIR%\php
set COMPOSER_PHAR=%BIN_DIR%\composer.phar

IF NOT EXIST %BIN_DIR% ( mkdir %BIN_DIR% )

ECHO|set/p=[96m[1/6] Check php binary...[0m
IF EXIST %PHP_DIR% (
    ECHO [36mAlready exists.[0m
) ELSE (
    powershell -Command "Invoke-WebRequest https://git.io/pm-php -OutFile php.zip"
    powershell -command "Expand-Archive -Force php.zip bin/php"
    del /f php.zip > nul
    ECHO [92mSuccessfully installed.[0m
)
ECHO.

ECHO|set/p=[96m[2/6] Check composer file...[0m
IF EXIST %COMPOSER_PHAR% (
    ECHO [36mAlready exists.[0m
) ELSE (
    powershell -Command "Invoke-WebRequest https://getcomposer.org/composer-stable.phar -OutFile %COMPOSER_PHAR%"
    ECHO [92mSuccessfully installed.[0m
)
ECHO.

ECHO [96m[3/6] Update pmmp source git...[0m
IF EXIST %PMMP_DIR% (
    cd %PMMP_DIR%
    git checkout %CHANNEL%
    git pull
    git submodule update --init
) ELSE (
    git clone --recursive https://github.com/pmmp/PocketMine-MP.git %PMMP_DIR% -b %CHANNEL%
)
ECHO.

ECHO [96m[4/6] Update composer dependency...[0m
cd %PMMP_DIR%
%PHP% %COMPOSER_PHAR% install --no-dev --classmap-authoritative --ignore-platform-reqs --no-interaction
ECHO.

ECHO [96m[5/6] Build PocketMine-MP...[0m
cd %PMMP_DIR%
%PHP% %COMPOSER_PHAR% make-server
MOVE PocketMine-MP.phar ..\..\PocketMine-MP.phar > nul
ECHO.

ECHO [96m[6/6] Build DevTools...[0m
cd %PMMP_DIR%\tests\plugins\DevTools
set PLUGINS_DIR=%BASE_DIR%\plugins

IF NOT EXIST %PLUGINS_DIR% ( MKDIR %PLUGINS_DIR% )
%PHP% -dphar.readonly=0 ./src\ConsoleScript.php --make ./ --out %PLUGINS_DIR%\DevTools.phar
ECHO.
ECHO.
ECHO [96m[*/*] All processing are done![0m
PAUSE > nul