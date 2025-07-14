# Universal Project Template Generator Setup Script (PowerShell)

Write-Host "🚀 Setting up Universal Project Template Generator..." -ForegroundColor Cyan

# Check PowerShell version
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Host "❌ PowerShell 5.0 or higher required" -ForegroundColor Red
    exit 1
}

Write-Host "✅ PowerShell version OK" -ForegroundColor Green

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
            Write-Host "💡 You can still use the PowerShell script" -ForegroundColor Gray
        }
    }
} catch {
    Write-Host "⚠️ Python not available" -ForegroundColor Yellow
}

# Test the PowerShell script
Write-Host "🧪 Testing PowerShell script..." -ForegroundColor Cyan

try {
    # Test creating a sample project
    Write-Host "📝 Creating test project..." -ForegroundColor Gray
    .\create-project.ps1 -Name "Test Project" -Type "web" -Description "Test project for validation" -Author "Test User" -Email "test@example.com"
    
    if (Test-Path "Test-Project") {
        Write-Host "✅ Test project created successfully!" -ForegroundColor Green
        Write-Host "🧹 Cleaning up test project..." -ForegroundColor Gray
        Remove-Item -Path "Test-Project" -Recurse -Force
    } else {
        Write-Host "❌ Test project creation failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ PowerShell script test failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Usage Examples:" -ForegroundColor Cyan
Write-Host "  .\create-project.ps1 -Name 'My Website' -Type 'web' -Git" -ForegroundColor White
Write-Host "  .\create-project.ps1 -Name 'Data Analysis' -Type 'python' -Author 'Your Name'" -ForegroundColor White
Write-Host "  python create-project-fixed.py 'My Project' --type web --git" -ForegroundColor White
Write-Host ""
Write-Host "🎯 Available types: web, python, node, react" -ForegroundColor Gray
Write-Host "📖 See README.md for full documentation" -ForegroundColor Gray
