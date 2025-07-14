@echo off
title Batch-Test - Development Server
color 0B
echo.
echo ================================================
echo   BATCH-TEST - DEVELOPMENT SERVER  
echo ================================================
echo.
cd /d "%~dp0\.."
if exist "05-utilities\scripts\serve.py" (
    python "05-utilities\scripts\serve.py"
) else (
    echo Starting basic file server...
    if exist "01-core\index.html" (
        start "" "01-core\index.html"
    ) else (
        echo Open files in 01-core/ folder to get started
    )
)
pause