@echo off
REM ================================================================
REM        UNIVERSAL PROJECT TEMPLATE GENERATOR
REM ================================================================
REM
REM Simple launcher - Just double-click this file to start!
REM

title Universal Project Template Generator
color 0A
cls

echo.
echo ================================================================
echo        UNIVERSAL PROJECT TEMPLATE GENERATOR
echo ================================================================
echo.
echo Welcome! This tool creates professional project structures
echo for web development, Python apps, APIs, and more.
echo.
echo ================================================================
echo.

:MENU
echo Choose an option:
echo.
echo [1] Create New Project (Interactive)
echo [2] Create New Project (Quick)
echo [3] View Available Project Types
echo [4] Open Documentation
echo [5] Exit
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto INTERACTIVE
if "%choice%"=="2" goto QUICK
if "%choice%"=="3" goto TYPES
if "%choice%"=="4" goto DOCS
if "%choice%"=="5" goto EXIT
echo Invalid choice. Please try again.
echo.
goto MENU

:INTERACTIVE
cls
echo ================================================================
echo        CREATE NEW PROJECT - INTERACTIVE MODE
echo ================================================================
echo.
set /p project_name="Enter project name: "
if "%project_name%"=="" (
    echo Project name cannot be empty!
    pause
    goto MENU
)

echo.
echo Available project types:
echo [1] Web (HTML/CSS/JS website)
echo [2] Python (Python application)
echo [3] Node (Node.js application)
echo [4] React (React application)
echo [5] Docs (Documentation project)
echo.
set /p type_choice="Choose project type (1-5): "

if "%type_choice%"=="1" set "project_type=web"
if "%type_choice%"=="2" set "project_type=python"
if "%type_choice%"=="3" set "project_type=node"
if "%type_choice%"=="4" set "project_type=react"
if "%type_choice%"=="5" set "project_type=docs"

if "%project_type%"=="" (
    echo Invalid project type!
    pause
    goto MENU
)

set /p project_desc="Enter project description (optional): "
if "%project_desc%"=="" set "project_desc=A new %project_type% project"

echo.
echo Creating project: %project_name%
echo Type: %project_type%
echo Description: %project_desc%
echo.
pause

python "%~dp0core\create-project.py" "%project_name%" --type "%project_type%" --description "%project_desc%" --author "%USERNAME%" --git

echo.
echo ================================================================
echo Project created successfully!
echo ================================================================
pause
goto MENU

:QUICK
cls
echo ================================================================
echo        CREATE NEW PROJECT - QUICK MODE
echo ================================================================
echo.
set /p project_name="Enter project name: "
if "%project_name%"=="" (
    echo Project name cannot be empty!
    pause
    goto MENU
)

echo.
echo Creating web project: %project_name%
python "%~dp0core\create-project.py" "%project_name%" --type "web" --description "A new web project" --author "%USERNAME%" --git

echo.
echo ================================================================
echo Project created successfully!
echo ================================================================
pause
goto MENU

:TYPES
cls
echo ================================================================
echo        AVAILABLE PROJECT TYPES
echo ================================================================
echo.
echo WEB.......... HTML/CSS/JavaScript website
echo PYTHON....... Python application with virtual environment
echo NODE......... Node.js application with package.json
echo REACT........ React application with modern setup
echo DOCS......... Documentation project with MkDocs
echo.
echo Each project includes:
echo - Professional folder structure (01-core, 02-assets, etc.)
echo - README with setup instructions
echo - Git repository initialization
echo - Development utilities and scripts
echo.
pause
goto MENU

:DOCS
cls
echo ================================================================
echo        DOCUMENTATION
echo ================================================================
echo.
echo Opening documentation files...
echo.

if exist "%~dp0README.md" (
    echo Opening main README...
    start "" "%~dp0README.md"
)

if exist "%~dp0core\INSTALL.md" (
    echo Opening installation guide...
    start "" "%~dp0core\INSTALL.md"
)

echo.
echo Documentation opened in your default text editor.
pause
goto MENU

:EXIT
cls
echo.
echo Thank you for using Universal Project Template Generator!
echo.
pause
exit /b 0
