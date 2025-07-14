# Universal Project Template Generator Setup Script (PowerShell)

Write-Host "🚀 Setting up Universal Project Template Generator..." -ForegroundColor Cyan

# Check PowerShell version
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Host "❌ PowerShell 5.0 or higher required" -ForegroundColor Red
    exit 1
}

Write-Host "✅ PowerShell version OK" -ForegroundColor Green

# Check and fix execution policy if needed
$currentPolicy = Get-ExecutionPolicy
Write-Host "Current execution policy: $currentPolicy" -ForegroundColor Gray

if ($currentPolicy -eq "Restricted") {
    Write-Host "⚠️ PowerShell execution policy is Restricted" -ForegroundColor Yellow
    Write-Host "Attempting to set execution policy for current user..." -ForegroundColor Yellow
    
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-Host "✅ Execution policy updated to RemoteSigned for current user" -ForegroundColor Green
    } catch {
        Write-Host "❌ Could not update execution policy. You may need to run as administrator." -ForegroundColor Red
        Write-Host "Manual fix: Run 'Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser'" -ForegroundColor Yellow
    }
}

# Check Python availability
try {
    $pythonVersion = python --version 2>$null
    if ($pythonVersion) {
        Write-Host "✅ Python found: $pythonVersion" -ForegroundColor Green
    } else {
        $pythonVersion = python3 --version 2>$null
        if ($pythonVersion) {
            Write-Host "✅ Python3 found: $pythonVersion" -ForegroundColor Green
        } else {
            Write-Host "⚠️ Python not found in PATH" -ForegroundColor Yellow
            Write-Host "💡 Please install Python 3.6+ from python.org" -ForegroundColor Gray
        }
    }
} catch {
    Write-Host "⚠️ Python not available" -ForegroundColor Yellow
}

# Test the Python script (recommended method)
Write-Host "🧪 Testing Python script..." -ForegroundColor Cyan

try {
    # Test creating a sample project
    Write-Host "📝 Creating test project..." -ForegroundColor Gray
    python create-project.py "Setup-Test" --type web --description "Setup validation test" --author "Setup Script"
    
    if (Test-Path "Setup-Test") {
        Write-Host "✅ Python script working perfectly!" -ForegroundColor Green
        Write-Host "🧹 Cleaning up test project..." -ForegroundColor Gray
        Remove-Item -Path "Setup-Test" -Recurse -Force
    } else {
        Write-Host "❌ Python script test failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Python script test failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 Make sure Python 3.6+ is installed and in your PATH" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Usage Examples:" -ForegroundColor Cyan
Write-Host "  python create-project.py 'My Website' --type web --git" -ForegroundColor White
Write-Host "  python create-project.py 'Data Analysis' --type python --author 'Your Name'" -ForegroundColor White  
Write-Host "  create-project.bat 'My Project' web 'Description'  # Windows easy mode" -ForegroundColor White
Write-Host ""
Write-Host "🎯 Available types: web, python, node, react, django, api, docs" -ForegroundColor Gray
Write-Host "📖 See README.md for full documentation" -ForegroundColor Gray
Write-Host "🚀 Ready to create amazing projects!" -ForegroundColor Green
