# Universal Project Template Generator (PowerShell)
# Creates structured projects with development utilities and status reporting
# Based on Project Ares architecture

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [ValidateSet("web", "python", "node", "react", "django", "api", "docs")]
    [string]$Type = "web",
    
    [string]$Description = "",
    [string]$Author = $env:USERNAME,
    [string]$Email = "your.email@example.com",
    [string]$Path = ".",
    [switch]$Git
)

# Color functions for better output
function Write-Success { param($Message) Write-Host $Message -ForegroundColor Green }
function Write-Info { param($Message) Write-Host $Message -ForegroundColor Cyan }
function Write-Warning { param($Message) Write-Host $Message -ForegroundColor Yellow }
function Write-Error { param($Message) Write-Host $Message -ForegroundColor Red }

# Sanitize project name for file system
$SafeName = $Name -replace '[^\w\s-]', '' -replace '\s+', '-'
$ProjectPath = Join-Path $Path $SafeName

Write-Info "🚀 Creating project: $Name"
Write-Info "📁 Location: $ProjectPath"
Write-Info "🎯 Type: $Type"

# Create main project directory
if (Test-Path $ProjectPath) {
    Write-Error "❌ Directory already exists: $ProjectPath"
    exit 1
}

New-Item -ItemType Directory -Path $ProjectPath -Force | Out-Null
Set-Location $ProjectPath

# ========== FOLDER STRUCTURE ========== 
$folders = @(
    "01-core",
    "02-assets/images",
    "02-assets/docs", 
    "03-content/data",
    "04-docs/specs",
    "05-utilities/scripts/repo-status"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
    Write-Success "✅ Created: $folder"
}

# ========== PROJECT-SPECIFIC FILES ========== 
switch ($Type.ToLower()) {
    "web" {
        # HTML5 starter with Project Ares structure
        @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="$Description">
    <meta name="author" content="$Author">
    <title>$Name</title>
    <link rel="stylesheet" href="style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Merriweather:wght@300;400;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="main-header">
        <div class="progress-bar">
            <div class="progress-fill" id="progress-fill"></div>
        </div>
        <nav class="sticky-nav" id="sticky-nav">
            <div class="nav-toggle" id="nav-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <div class="nav-content">
                <h3>Navigation</h3>
                <ul>
                    <li><a href="#section-1">Section 1</a></li>
                    <li><a href="#section-2">Section 2</a></li>
                    <li><a href="#section-3">Section 3</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <main class="main-content">
        <section id="section-1" class="section">
            <h1>$Name</h1>
            <p class="subtitle">$Description</p>
            
            <div class="content-placeholder">
                <h2>Welcome to your new project!</h2>
                <p>This project was generated with the Universal Project Template Generator.</p>
                <p>Start editing this file to build your application.</p>
            </div>
        </section>

        <section id="section-2" class="section">
            <h2>Getting Started</h2>
            <div class="content-placeholder">
                <p>1. Edit files in the &lt;code&gt;01-core/&lt;/code&gt; folder</p>
                <p>2. Add assets to &lt;code&gt;02-assets/&lt;/code&gt;</p>
                <p>3. Store data in &lt;code&gt;03-content/&lt;/code&gt;</p>
                <p>4. Document in &lt;code&gt;04-docs/&lt;/code&gt;</p>
                <p>5. Use utilities in &lt;code&gt;05-utilities/&lt;/code&gt;</p>
            </div>
        </section>

        <section id="section-3" class="section">
            <h2>Development Tools</h2>
            <div class="content-placeholder">
                <p>🚀 &lt;strong&gt;Start Server:&lt;/strong&gt; Double-click &lt;code&gt;05-utilities\start-server.bat&lt;/code&gt;</p>
                <p>📊 &lt;strong&gt;Generate Status:&lt;/strong&gt; Double-click &lt;code&gt;05-utilities\generate-status.bat&lt;/code&gt;</p>
            </div>
        </section>
    </main>

    <button class="back-to-top" id="back-to-top" aria-label="Back to top">↑</button>

    <footer class="main-footer">
        <div class="footer-content">
            <p>&copy; $(Get-Date -Format 'yyyy') $Name. Created by $Author</p>
        </div>
    </footer>

    <script src="script.js"></script>
</body>
</html>
"@ | Out-File -FilePath "01-core/index.html" -Encoding UTF8

        # Modern CSS framework (simplified Project Ares styles)
        @"
/* $Name - Modern CSS Framework */
/* Based on Project Ares architecture */

/* ========== RESET & BASE ========== */
* { margin: 0; padding: 0; box-sizing: border-box; }

html { scroll-behavior: smooth; }

body {
    font-family: 'Merriweather', Georgia, serif;
    font-size: 1.1rem;
    line-height: 1.7;
    color: #333;
    background: #F8F8F8;
    overflow-x: hidden;
}

/* ========== TYPOGRAPHY ========== */
h1, h2, h3, h4, h5, h6 {
    font-family: 'Open Sans', Arial, sans-serif;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #2C3E50;
}

h1 { font-size: 2.5rem; font-weight: 700; margin-bottom: 1.5rem; }
h2 { font-size: 2rem; margin-bottom: 1.2rem; }
h3 { font-size: 1.5rem; margin-bottom: 1rem; }

p { margin-bottom: 1.2rem; }

a {
    color: #4682B4;
    text-decoration: none;
    transition: color 0.3s ease;
}

a:hover {
    color: #6B8E23;
    text-decoration: underline;
}

/* ========== LAYOUT ========== */
.main-header {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    background: rgba(248, 248, 248, 0.95);
    backdrop-filter: blur(10px);
    border-bottom: 1px solid #E0E0E0;
}

.progress-bar {
    height: 3px;
    background: #E0E0E0;
    position: relative;
}

.progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #4682B4, #6B8E23);
    width: 0%;
    transition: width 0.3s ease;
}

.main-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 80px 2rem 2rem;
    background: white;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    min-height: 100vh;
}

/* ========== NAVIGATION ========== */
.sticky-nav {
    position: fixed;
    top: 60px;
    left: 20px;
    width: 280px;
    max-height: calc(100vh - 80px);
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
    z-index: 999;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
    padding: 1.5rem;
}

.sticky-nav.active { transform: translateX(0); }

.nav-toggle {
    position: fixed;
    top: 15px;
    left: 20px;
    width: 30px;
    height: 30px;
    cursor: pointer;
    z-index: 1001;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 5px 0;
}

.nav-toggle span {
    display: block;
    height: 3px;
    background: #333;
    border-radius: 1px;
    transition: all 0.3s ease;
}

.nav-toggle.active span:nth-child(1) { transform: rotate(45deg) translate(5px, 5px); }
.nav-toggle.active span:nth-child(2) { opacity: 0; }
.nav-toggle.active span:nth-child(3) { transform: rotate(-45deg) translate(7px, -6px); }

.nav-content ul { list-style: none; }
.nav-content li { margin-bottom: 0.5rem; }
.nav-content li a {
    display: block;
    padding: 0.5rem 0;
    color: #555;
    font-size: 0.9rem;
    transition: all 0.3s ease;
}

.nav-content li a:hover {
    background: #EDF2F7;
    padding-left: 0.5rem;
    text-decoration: none;
}

/* ========== SECTIONS ========== */
.section { margin-bottom: 3rem; }

.content-placeholder {
    background: #F9F9F9;
    border: 2px dashed #E0E0E0;
    border-radius: 8px;
    padding: 2rem;
    margin: 1rem 0;
}

/* ========== BACK TO TOP ========== */
.back-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background: #4682B4;
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    font-size: 1.2rem;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 999;
}

.back-to-top.visible {
    opacity: 1;
    visibility: visible;
}

.back-to-top:hover {
    background: #5a94c7;
    transform: scale(1.1);
}

/* ========== FOOTER ========== */
.main-footer {
    background: #2C3E50;
    color: white;
    text-align: center;
    padding: 2rem;
    margin-top: 3rem;
}

/* ========== RESPONSIVE ========== */
@media (max-width: 768px) {
    .main-content { padding: 80px 1rem 1rem; }
    .sticky-nav { width: 250px; left: -270px; }
    h1 { font-size: 2rem; }
    h2 { font-size: 1.7rem; }
}

@media (max-width: 480px) {
    body { font-size: 1rem; line-height: 1.6; }
    .main-content { padding: 70px 0.5rem 0.5rem; }
}
"@ | Out-File -FilePath "01-core/style.css" -Encoding UTF8

        # JavaScript with Project Ares interactivity
        @"
// $Name - Interactive JavaScript
// Based on Project Ares architecture

document.addEventListener('DOMContentLoaded', function() {
    // Elements
    const navToggle = document.getElementById('nav-toggle');
    const stickyNav = document.getElementById('sticky-nav');
    const backToTop = document.getElementById('back-to-top');
    const progressFill = document.getElementById('progress-fill');

    // Navigation toggle
    if (navToggle && stickyNav) {
        navToggle.addEventListener('click', function() {
            navToggle.classList.toggle('active');
            stickyNav.classList.toggle('active');
        });

        // Close navigation when clicking outside
        document.addEventListener('click', function(event) {
            if (!stickyNav.contains(event.target) && !navToggle.contains(event.target)) {
                navToggle.classList.remove('active');
                stickyNav.classList.remove('active');
            }
        });
    }

    // Scroll progress indicator
    function updateProgressBar() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
        const progress = (scrollTop / scrollHeight) * 100;
        
        if (progressFill) {
            progressFill.style.width = Math.min(progress, 100) + '%';
        }
    }

    // Back to top functionality
    function updateBackToTop() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (backToTop) {
            if (scrollTop > 300) {
                backToTop.classList.add('visible');
            } else {
                backToTop.classList.remove('visible');
            }
        }
    }

    if (backToTop) {
        backToTop.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // Scroll handlers
    window.addEventListener('scroll', function() {
        updateProgressBar();
        updateBackToTop();
    });

    // Smooth scrolling for internal links
    document.querySelectorAll('a[href^="#"]').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            if (targetElement) {
                const offsetTop = targetElement.offsetTop - 80;
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
                
                // Close navigation if open
                if (navToggle && stickyNav) {
                    navToggle.classList.remove('active');
                    stickyNav.classList.remove('active');
                }
            }
        });
    });

    // Keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            if (navToggle && stickyNav) {
                navToggle.classList.remove('active');
                stickyNav.classList.remove('active');
            }
        }
    });

    // Initialize
    updateProgressBar();
    updateBackToTop();
    
    console.log('$Name initialized successfully');
});
"@ | Out-File -FilePath "01-core/script.js" -Encoding UTF8
    }
    
    "python" {
        # Python project structure
        @"
# $Name
"""
$Description

Author: $Author <$Email>
Created: $(Get-Date -Format 'yyyy-MM-dd')
"""

def main():
    """Main entry point for $Name."""
    print("Welcome to $Name")
    print("$Description")

if __name__ == "__main__":
    main()
"@ | Out-File -FilePath "01-core/main.py" -Encoding UTF8

        # Requirements file
        @"
# $Name Dependencies
# Add your Python packages here

# Common packages for most projects
requests>=2.28.0
numpy>=1.21.0
pandas>=1.4.0

# Development dependencies
pytest>=7.0.0
black>=22.0.0
flake8>=4.0.0
"@ | Out-File -FilePath "01-core/requirements.txt" -Encoding UTF8

        # Virtual environment setup
        @"
# $Name - Python Environment Setup

## Setup Virtual Environment
```bash
# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Activate (Linux/Mac)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

## Run Project
```bash
python main.py
```
"@ | Out-File -FilePath "01-core/PYTHON_SETUP.md" -Encoding UTF8
    }
    
    "node" {
        # Package.json for Node projects
        @"
{
  "name": "$($SafeName.ToLower())",
  "version": "1.0.0",
  "description": "$Description",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest",
    "lint": "eslint .",
    "format": "prettier --write ."
  },
  "keywords": ["$Type", "project", "template"],
  "author": "$Author <$Email>",
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "helmet": "^6.0.1"
  },
  "devDependencies": {
    "nodemon": "^2.0.20",
    "jest": "^29.0.0",
    "eslint": "^8.0.0",
    "prettier": "^2.8.0"
  }
}
"@ | Out-File -FilePath "01-core/package.json" -Encoding UTF8

        # Basic Node.js entry
        @"
// $Name - Node.js Application
// $Description

const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => {
    res.json({
        name: '$Name',
        description: '$Description',
        author: '$Author',
        version: '1.0.0',
        status: 'running'
    });
});

app.get('/api/health', (req, res) => {
    res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Start server
app.listen(port, () => {
    console.log(`🚀 $Name server running on port `${port}`);
    console.log(`📖 Open http://localhost:`${port}` in your browser`);
});

module.exports = app;
"@ | Out-File -FilePath "01-core/index.js" -Encoding UTF8
    }

    "react" {
        # React package.json
        @"
{
  "name": "$($SafeName.ToLower())",
  "version": "1.0.0",
  "description": "$Description",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.8.0",
    "react-scripts": "5.0.1"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "keywords": ["react", "$Type", "project"],
  "author": "$Author <$Email>",
  "license": "MIT",
  "browserslist": {
    "production": [">0.2%", "not dead", "not op_mini all"],
    "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]
  }
}
"@ | Out-File -FilePath "01-core/package.json" -Encoding UTF8

        # React App component
        @"
import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>$Name</h1>
        <p>$Description</p>
        <p>Created by: $Author</p>
        <div className="App-links">
          <a href="#getting-started">Get Started</a>
          <a href="#documentation">Documentation</a>
        </div>
      </header>
      
      <main className="App-main">
        <section id="getting-started">
          <h2>Getting Started</h2>
          <p>Your React application is ready! Start editing to build your app.</p>
        </section>
      </main>
    </div>
  );
}

export default App;
"@ | Out-File -FilePath "01-core/src/App.js" -Encoding UTF8

        # React CSS
        @"
.App {
  text-align: center;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.App-header {
  background: linear-gradient(135deg, #4682B4, #6B8E23);
  padding: 3rem 2rem;
  color: white;
}

.App-header h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  font-weight: 700;
}

.App-header p {
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
}

.App-links {
  margin-top: 2rem;
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.App-links a {
  background: rgba(255,255,255,0.2);
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  text-decoration: none;
  transition: all 0.3s ease;
}

.App-links a:hover {
  background: rgba(255,255,255,0.3);
  transform: translateY(-2px);
}

.App-main {
  flex: 1;
  padding: 3rem 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.App-main section {
  margin-bottom: 3rem;
  text-align: left;
}

.App-main h2 {
  color: #2C3E50;
  margin-bottom: 1rem;
}

@media (max-width: 768px) {
  .App-header h1 { font-size: 2rem; }
  .App-header p { font-size: 1rem; }
  .App-links { flex-direction: column; align-items: center; }
  .App-main { padding: 2rem 1rem; }
}
"@ | Out-File -FilePath "01-core/src/App.css" -Encoding UTF8

        # React index.js
        @"
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
"@ | Out-File -FilePath "01-core/src/index.js" -Encoding UTF8

        # React index.css
        @"
body {
  margin: 0;
  font-family: 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
}

code {
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
}

* {
  box-sizing: border-box;
}
"@ | Out-File -FilePath "01-core/src/index.css" -Encoding UTF8

        # React public HTML
        @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="$Description" />
    <title>$Name</title>
</head>
<body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
</body>
</html>
"@ | Out-File -FilePath "01-core/public/index.html" -Encoding UTF8

        New-Item -ItemType Directory -Path "01-core/src" -Force | Out-Null
        New-Item -ItemType Directory -Path "01-core/public" -Force | Out-Null
    }
}

# ========== UNIVERSAL README ========== 
@"
# $Name

$Description

## 🚀 Quick Start

### Development
1. **Start development:** Double-click ``05-utilities\start-server.bat``
2. **Edit files:** Modify files in ``01-core/`` folder  
3. **Generate status:** Double-click ``05-utilities\generate-status.bat``

### Project Structure
```
$SafeName/
├── 01-core/           # Main application files
├── 02-assets/         # Static assets (images, docs)
├── 03-content/        # Content and data files
├── 04-docs/           # Project documentation
└── 05-utilities/      # Development tools
    ├── start-server.bat      # 🖱️ Start development server
    ├── generate-status.bat   # 🖱️ Generate project status
    └── scripts/              # Utility scripts
```

## 📊 Project Status

Run ``05-utilities\generate-status.bat`` to generate a comprehensive project report perfect for sharing with AI assistants.

## 👨‍💻 Development

- **Project Type:** $Type
- **Author:** $Author
- **Email:** $Email
- **Created:** $(Get-Date -Format 'yyyy-MM-dd')

$(if ($Type -eq "python") {
@"

## Python Setup

1. Create virtual environment: ``python -m venv venv``
2. Activate environment: ``venv\Scripts\activate`` (Windows) or ``source venv/bin/activate`` (Linux/Mac)
3. Install dependencies: ``pip install -r 01-core/requirements.txt``
4. Run application: ``python 01-core/main.py``
"@
} elseif ($Type -eq "node" -or $Type -eq "react") {
@"

## Node.js Setup

1. Install dependencies: ``npm install`` (in 01-core/ folder)
2. Start development: ``npm run dev`` or ``npm start``
3. Build for production: ``npm run build``
"@
})

---

*Generated with Universal Project Template Generator based on Project Ares architecture*
"@ | Out-File -FilePath "README.md" -Encoding UTF8

# ========== DEVELOPMENT UTILITIES ========== 
# Copy repo status generator from Project Ares with customization
@"
# $Name - Repository Status Generator
param([string]`$OutputFile = "05-utilities\scripts\repo-status\repo_status_$($SafeName.ToLower() -replace '-','_').txt")

`$ScriptDir = Split-Path -Parent `$MyInvocation.MyCommand.Path
`$ProjectRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent `$ScriptDir))
Set-Location `$ProjectRoot

`$Date = Get-Date -Format "ddd, MMM dd, yyyy hh:mm:ss tt"
`$OutPath = Join-Path `$ProjectRoot `$OutputFile

@"
==============================
$($Name.ToUpper()) – REPO SNAPSHOT  
Generated: `$Date
==============================

[PROJECT OVERVIEW]
Project: $Name
Type: $Type
Description: $Description
Author: $Author <$Email>
Created: $(Get-Date -Format 'yyyy-MM-dd')

[CORE PROJECT FILES STATUS]
"@ | Out-File -FilePath `$OutPath -Encoding UTF8

# Check core files existence and metrics
`$CoreFiles = Get-ChildItem "01-core" -File -Recurse 2>`$null
if (`$CoreFiles) {
    "[CORE APPLICATION FILES - 01-core]" | Add-Content `$OutPath
    foreach (`$file in `$CoreFiles) {
        `$size = [math]::Round(`$file.Length / 1KB, 1)
        `$relativePath = `$file.FullName.Replace((Get-Location).Path + "\", "")
        if (`$file.Extension -in @('.html','.css','.js','.py','.json','.jsx','.ts','.tsx')) {
            try {
                `$lines = (Get-Content `$file.FullName | Measure-Object -Line).Lines
                "PASS `$relativePath - `$(`$size)KB, `$lines lines" | Add-Content `$OutPath
            } catch {
                "PASS `$relativePath - `$(`$size)KB" | Add-Content `$OutPath
            }
        } else {
            "PASS `$relativePath - `$(`$size)KB" | Add-Content `$OutPath
        }
    }
} else {
    "WARNING: No core files found in 01-core/" | Add-Content `$OutPath
}

# Check project structure
"`n[PROJECT STRUCTURE]" | Add-Content `$OutPath
`$Directories = @("01-core", "02-assets", "03-content", "04-docs", "05-utilities")
foreach (`$dir in `$Directories) {
    if (Test-Path `$dir -PathType Container) {
        `$count = (Get-ChildItem `$dir -Recurse -File 2>`$null | Measure-Object).Count
        "PASS `$dir\ - `$count files" | Add-Content `$OutPath
    } else {
        "FAIL `$dir\ - MISSING" | Add-Content `$OutPath
    }
}

# Git status if available
"`n[GIT STATUS]" | Add-Content `$OutPath
try {
    `$branch = git symbolic-ref --short HEAD 2>`$null
    if (`$branch) {
        "Current branch: `$branch" | Add-Content `$OutPath
        `$status = git status --short 2>`$null
        if (`$status) {
            "Working directory changes:" | Add-Content `$OutPath
            `$status | Add-Content `$OutPath
        } else {
            "Working directory: CLEAN" | Add-Content `$OutPath
        }
        
        # Recent commits
        "`nRecent commits:" | Add-Content `$OutPath
        `$commits = git log -5 --pretty=format:"- %h %s (%cr)" 2>`$null
        if (`$commits) {
            `$commits | Add-Content `$OutPath
        }
    }
} catch {
    "Not a git repository or git not available" | Add-Content `$OutPath
}

# Project type specific checks
"`n[PROJECT TYPE: $($Type.ToUpper())]" | Add-Content `$OutPath
switch ("$Type") {
    "web" {
        if (Test-Path "01-core\index.html") { "✅ HTML entry point found" | Add-Content `$OutPath }
        if (Test-Path "01-core\style.css") { "✅ CSS stylesheet found" | Add-Content `$OutPath }
        if (Test-Path "01-core\script.js") { "✅ JavaScript found" | Add-Content `$OutPath }
    }
    "python" {
        if (Test-Path "01-core\main.py") { "✅ Python entry point found" | Add-Content `$OutPath }
        if (Test-Path "01-core\requirements.txt") { "✅ Requirements file found" | Add-Content `$OutPath }
    }
    "node" {
        if (Test-Path "01-core\package.json") { "✅ Package.json found" | Add-Content `$OutPath }
        if (Test-Path "01-core\index.js") { "✅ Node.js entry point found" | Add-Content `$OutPath }
    }
    "react" {
        if (Test-Path "01-core\package.json") { "✅ Package.json found" | Add-Content `$OutPath }
        if (Test-Path "01-core\src\App.js") { "✅ React App component found" | Add-Content `$OutPath }
        if (Test-Path "01-core\public\index.html") { "✅ React HTML template found" | Add-Content `$OutPath }
    }
}

"`n[DEVELOPMENT TOOLS]" | Add-Content `$OutPath
if (Test-Path "05-utilities\start-server.bat") { "✅ Start server utility available" | Add-Content `$OutPath }
if (Test-Path "05-utilities\generate-status.bat") { "✅ Status generator available" | Add-Content `$OutPath }
if (Test-Path "05-utilities\scripts\serve.py") { "✅ Python server script available" | Add-Content `$OutPath }
if (Test-Path "05-utilities\scripts\serve.ps1") { "✅ PowerShell server script available" | Add-Content `$OutPath }

"`n[SUMMARY]" | Add-Content `$OutPath
"Project: $Name" | Add-Content `$OutPath
"Type: $Type" | Add-Content `$OutPath
"Status: Ready for development" | Add-Content `$OutPath
"Generated: `$OutPath" | Add-Content `$OutPath
"Ready to share with AI assistants!" | Add-Content `$OutPath

Write-Host "STATUS: Project status generated at `$OutPath" -ForegroundColor Green
"@ | Out-File -FilePath "05-utilities/scripts/repo-status/generate_repo_status.ps1" -Encoding UTF8

# Start server batch file
@"
@echo off
title $Name - Development Server
color 0B
echo.
echo ================================================
echo   $($Name.ToUpper()) - DEVELOPMENT SERVER  
echo ================================================
echo.
cd /d "%~dp0\.."
"@ | Add-Content "05-utilities/start-server.bat"

# Add project-type specific server commands
switch ($Type) {
    "web" {
        @"
if exist "05-utilities\scripts\serve.ps1" (
    powershell -ExecutionPolicy Bypass -File "05-utilities\scripts\serve.ps1"
) else (
    echo Starting basic file server...
    if exist "01-core\index.html" (
        start "" "01-core\index.html"
    ) else (
        echo Open files in 01-core/ folder to get started
    )
)
"@ | Add-Content "05-utilities/start-server.bat"
    }
    "python" {
        @"
echo Starting Python application...
cd 01-core
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
    python main.py
) else (
    echo Warning: Virtual environment not found
    echo Run: python -m venv venv
    echo Then: venv\Scripts\activate
    echo Then: pip install -r requirements.txt
    python main.py
)
"@ | Add-Content "05-utilities/start-server.bat"
    }
    { $_ -in @("node", "react") } {
        @"
echo Starting Node.js application...
cd 01-core
if exist "package.json" (
    if not exist "node_modules" (
        echo Installing dependencies...
        npm install
    )
    npm start
) else (
    echo Error: package.json not found
    echo Run: npm init -y
)
"@ | Add-Content "05-utilities/start-server.bat"
    }
}

@"
pause
"@ | Add-Content "05-utilities/start-server.bat"

# Generate status batch file
@"
@echo off
title $Name - Repository Status
color 0E
echo.
echo ================================================
echo   $($Name.ToUpper()) - REPOSITORY STATUS
echo ================================================
echo.
cd /d "%~dp0\.."
powershell -ExecutionPolicy Bypass -File "05-utilities\scripts\repo-status\generate_repo_status.ps1"
echo.
echo Status report generated!
choice /C YN /M "Open the status report now"
if errorlevel 2 goto end
start notepad "05-utilities\scripts\repo-status\repo_status_$($SafeName.ToLower() -replace '-','_').txt"
:end
pause
"@ | Out-File -FilePath "05-utilities/generate-status.bat" -Encoding ASCII

# Development server scripts
if ($Type -eq "web") {
@"
# $Name Development Server
param([int]`$Port = 8000)

`$coreDir = Join-Path (Split-Path -Parent `$PSScriptRoot) "01-core"
Write-Host "🚀 $Name Development Server" -ForegroundColor Cyan
Write-Host "📂 Serving: `$coreDir" -ForegroundColor Gray

try {
    `$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if (-not `$pythonCmd) { `$pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue }
    
    if (`$pythonCmd) {
        Write-Host "🐍 Starting Python server on port `$Port" -ForegroundColor Green
        Set-Location `$coreDir
        Start-Process "http://localhost:`$Port"
        & `$pythonCmd.Source -m http.server `$Port
    } else {
        Write-Host "💡 Python not found - opening index.html directly" -ForegroundColor Yellow
        if (Test-Path "`$coreDir\index.html") {
            Start-Process "`$coreDir\index.html"
        }
    }
} catch {
    Write-Host "❌ Error: `$(`$_.Exception.Message)" -ForegroundColor Red
}
"@ | Out-File -FilePath "05-utilities/scripts/serve.ps1" -Encoding UTF8

@"
#!/usr/bin/env python3
"""
Simple development server for $Name
Run with: python serve.py
"""

import http.server
import socketserver
import webbrowser
import os
from pathlib import Path

PORT = 8000
DIRECTORY = Path(__file__).parent.parent / "01-core"

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

def main():
    try:
        with socketserver.TCPServer(("", PORT), CustomHTTPRequestHandler) as httpd:
            print(f"🚀 $Name Development Server")
            print(f"📂 Serving directory: {DIRECTORY}")
            print(f"🌐 Server running at: http://localhost:{PORT}")
            print(f"⭐ Press Ctrl+C to stop the server")
            
            try:
                webbrowser.open(f"http://localhost:{PORT}")
                print(f"🌟 Browser opened automatically")
            except:
                print(f"💡 Please manually open: http://localhost:{PORT}")
            
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print(f"\n🛑 Server stopped by user")
    except OSError as e:
        if e.errno == 48:
            print(f"❌ Port {PORT} is already in use")
        else:
            print(f"❌ Error starting server: {e}")

if __name__ == "__main__":
    main()
"@ | Out-File -FilePath "05-utilities/scripts/serve.py" -Encoding UTF8
}

# ========== GIT INITIALIZATION ========== 
if ($Git) {
    try {
        git init | Out-Null
        
        # Create appropriate .gitignore
        switch ($Type) {
            "web" {
                @"
# $Name - Web Project .gitignore
node_modules/
*.log
.env
.DS_Store
Thumbs.db
dist/
build/
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
            }
            "python" {
                @"
# $Name - Python Project .gitignore
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual environments
venv/
env/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
            }
            { $_ -in @("node", "react") } {
                @"
# $Name - Node.js Project .gitignore
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/
*.lcov

# nyc test coverage
.nyc_output

# Dependency directories
node_modules/
jspm_packages/

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env
.env.test
.env.production

# Build outputs
build/
dist/

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
            }
        }
        
        git add .
        git commit -m "Initial commit: $Name project structure ($Type)" | Out-Null
        Write-Success "✅ Git repository initialized"
    } catch {
        Write-Warning "⚠️ Git initialization failed: $($_.Exception.Message)"
    }
}

# ========== COMPLETION ========== 
Write-Success "`n🎉 Project '$Name' created successfully!"
Write-Info "📁 Location: $ProjectPath"
Write-Info "🎯 Type: $Type"
Write-Success "`n🚀 Next steps:"
Write-Info "  1. Navigate to project: cd `"$SafeName`""

switch ($Type) {
    "web" {
        Write-Info "  2. Start development: Double-click 05-utilities\start-server.bat"
    }
    "python" {
        Write-Info "  2. Setup environment: python -m venv venv"
        Write-Info "  3. Activate environment: venv\Scripts\activate"
        Write-Info "  4. Install dependencies: pip install -r 01-core\requirements.txt"
        Write-Info "  5. Start development: python 01-core\main.py"
    }
    { $_ -in @("node", "react") } {
        Write-Info "  2. Install dependencies: cd 01-core && npm install"
        Write-Info "  3. Start development: npm start"
    }
}

Write-Info "  📊 Generate status: Double-click 05-utilities\generate-status.bat"
Write-Info "`n📖 See README.md for full instructions"

# Return to original location
Set-Location (Split-Path -Parent $ProjectPath)
