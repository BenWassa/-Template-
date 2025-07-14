@echo off
title Batch-Test - Repository Status
color 0E
echo.
echo ================================================
echo   BATCH-TEST - REPOSITORY STATUS
echo ================================================
echo.
cd /d "%~dp0\.."
python "05-utilities\scripts\repo-status\generate_status.py"
echo.
echo Status report generated!
choice /C YN /M "Open the status report now"
if errorlevel 2 goto end
if exist "05-utilities\scripts\repo-status\repo_status_batch_test.txt" (
    start notepad "05-utilities\scripts\repo-status\repo_status_batch_test.txt"
)
:end
pause