@echo off

echo The Calling - Courtiers of Renown - Mod Deployment Script
echo ==============================================

set "MOD_NAME=TheCalling"
set "SOURCE_DIR=%~dp0mod"
set "DESCRIPTOR_SOURCE=%~dp0descriptor.mod"

set "CK3_MOD_DIR=%USERPROFILE%\Documents\Paradox Interactive\Crusader Kings III\mod"

if not exist "%SOURCE_DIR%" (
    echo ERROR: Source mod folder not found at: "%SOURCE_DIR%"
    echo Please run this script from the project root directory.
    pause
    exit /b 1
)

if not exist "%DESCRIPTOR_SOURCE%" (
    echo ERROR: descriptor.mod file not found at: "%DESCRIPTOR_SOURCE%"
    echo Please run this script from the project root directory.
    pause
    exit /b 1
)

if not exist "%CK3_MOD_DIR%" (
    echo Creating CK3 mod directory: "%CK3_MOD_DIR%"
    mkdir "%CK3_MOD_DIR%"
)
if not exist "%CK3_MOD_DIR%" (
    echo ERROR: Could not create the CK3 mod directory: "%CK3_MOD_DIR%"
    pause
    exit /b 1
)

echo.
echo Source Directory: "%SOURCE_DIR%"
echo Target Directory: "%CK3_MOD_DIR%"
echo.

if exist "%CK3_MOD_DIR%\%MOD_NAME%" (
    echo Removing existing mod installation...
    rmdir /s /q "%CK3_MOD_DIR%\%MOD_NAME%"
)
if exist "%CK3_MOD_DIR%\%MOD_NAME%" (
    echo ERROR: Could not remove the old installation: "%CK3_MOD_DIR%\%MOD_NAME%"
    echo Close CK3 and the launcher, then run this script again.
    pause
    exit /b 1
)

if exist "%CK3_MOD_DIR%\%MOD_NAME%.mod" (
    echo Removing existing mod descriptor...
    del "%CK3_MOD_DIR%\%MOD_NAME%.mod"
)
if exist "%CK3_MOD_DIR%\%MOD_NAME%.mod" (
    echo ERROR: Could not remove the old descriptor: "%CK3_MOD_DIR%\%MOD_NAME%.mod"
    echo Close CK3 and the launcher, then run this script again.
    pause
    exit /b 1
)

echo Copying mod folder...
xcopy "%SOURCE_DIR%" "%CK3_MOD_DIR%\%MOD_NAME%\" /E /I /H /Y
if errorlevel 1 (
    echo ERROR: Failed to copy mod folder
    pause
    exit /b 1
)

echo Copying mod descriptor...
copy "%DESCRIPTOR_SOURCE%" "%CK3_MOD_DIR%\%MOD_NAME%.mod"
if errorlevel 1 (
    echo ERROR: Failed to copy descriptor file
    pause
    exit /b 1
)

echo.
echo ==============================================
echo Deployment Complete!
echo ==============================================
echo.
echo Mod Location: "%CK3_MOD_DIR%\%MOD_NAME%\"
echo Descriptor:   "%CK3_MOD_DIR%\%MOD_NAME%.mod"
echo.
echo Next Steps:
echo 1. Start CK3 Launcher
echo 2. Go to Mods tab
echo 3. Enable "The Calling - Courtiers of Renown"
echo 4. Create or select a playset
echo 5. Start the game to test
echo.
echo To test in game: as a landed ruler, take the "Call Maidens to Court"
echo decision. Three maidens arrive a week later;
echo pick one to join your court. The game rule "The Calling:
echo Congenital Traits" sets their chance of a positive congenital trait.
echo.
echo Note: enable only this local copy. Do not enable a Workshop
echo subscription of the mod in the same playset.
echo.
