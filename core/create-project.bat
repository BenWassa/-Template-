@echo off
REM Universal Project Template Generator - Windows Batch Wrapper
title Project Template Generator

echo.
echo ================================================
echo   UNIVERSAL PROJECT TEMPLATE GENERATOR
echo ================================================
echo.

REM Check if arguments were provided
if "%~1"=="" (
    echo Usage: create-project.bat "Project Name" [type] [description]
    echo.
    echo Examples:
    echo   create-project.bat "My Website"
    echo   create-project.bat "My App" web "A cool website"
    echo   create-project.bat "My API" node "REST API server"
    echo.
    echo Supported types: web, python, node, react, django, api, docs
    echo.
    pause
    exit /b 1
)

REM Get parameters
set "PROJECT_NAME=%~1"
set "PROJECT_TYPE=%~2"
set "PROJECT_DESC=%~3"

if "%PROJECT_TYPE%"=="" set "PROJECT_TYPE=web"
if "%PROJECT_DESC%"=="" set "PROJECT_DESC=A new project"

echo Creating project: %PROJECT_NAME%
echo Type: %PROJECT_TYPE%
echo Description: %PROJECT_DESC%
echo.

REM Use Python version (reliable cross-platform solution)
python "%~dp0create-project.py" "%PROJECT_NAME%" --type "%PROJECT_TYPE%" --description "%PROJECT_DESC%" --author "%USERNAME%"

echo.
echo Project creation complete!
pause
