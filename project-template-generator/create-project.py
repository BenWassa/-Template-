#!/usr/bin/env python3
"""
Universal Project Template Generator (Python)
Cross-platform project creation with development utilities and status reporting
Based on Project Ares architecture
"""

import os
import sys
import argparse
import json
import subprocess
from pathlib import Path
from datetime import datetime
import shutil

def sanitize_name(name):
    """Convert project name to filesystem-safe format"""
    import re
    return re.sub(r'[^\w\s-]', '', name).strip().replace(' ', '-')

def create_project(name, project_type="web", description="", author="", email="", path=".", git=False):
    """Create a new project with the specified parameters"""
    
    safe_name = sanitize_name(name)
    project_path = Path(path) / safe_name
    
    print(f"🚀 Creating project: {name}")
    print(f"📁 Location: {project_path}")
    print(f"🎯 Type: {project_type}")
    
    # Check if directory exists
    if project_path.exists():
        print(f"❌ Directory already exists: {project_path}")
        return False
    
    # Create main project directory
    project_path.mkdir(parents=True)
    os.chdir(project_path)
    
    # Create folder structure
    folders = [
        "01-core",
        "02-assets/images",
        "02-assets/docs",
        "03-content/data", 
        "04-docs/specs",
        "05-utilities/scripts/repo-status"
    ]
    
    for folder in folders:
        Path(folder).mkdir(parents=True, exist_ok=True)
        print(f"✅ Created: {folder}")
    
    # Create project-specific files
    if project_type == "web":
        create_web_files(name, description, author, email)
    elif project_type == "python":
        create_python_files(name, description, author, email)
    elif project_type == "node":
        create_node_files(name, safe_name, description, author, email)
    elif project_type == "react":
        create_react_files(name, safe_name, description, author, email)
    elif project_type == "django":
        create_django_files(name, safe_name, description, author, email)
    elif project_type == "api":
        create_api_files(name, safe_name, description, author, email)
    elif project_type == "docs":
        create_docs_files(name, description, author, email)
    
    # Create universal files
    create_readme(name, safe_name, project_type, description, author, email)
    create_utilities(name, safe_name, project_type, author, email)
    
    # Git initialization
    if git:
        create_gitignore(project_type)
        try:
            subprocess.run(["git", "init"], check=True, capture_output=True)
            subprocess.run(["git", "add", "."], check=True, capture_output=True)
            subprocess.run(["git", "commit", "-m", f"Initial commit: {name} project structure ({project_type})"], 
                         check=True, capture_output=True)
            print("✅ Git repository initialized")
        except subprocess.CalledProcessError as e:
            print(f"⚠️ Git initialization failed: {e}")
    
    print(f"\n🎉 Project '{name}' created successfully!")
    print(f"📁 Location: {project_path}")
    print(f"🎯 Type: {project_type}")
    
    # Next steps
    print("\n🚀 Next steps:")
    print(f"  1. Navigate to project: cd \"{safe_name}\"")
    
    if project_type == "web":
        print("  2. Start development: Double-click 05-utilities/start-server.bat (Windows)")
        print("     Or run: python 05-utilities/scripts/serve.py")
    elif project_type == "python":
        print("  2. Setup environment: python -m venv venv")
        print("  3. Activate environment: source venv/bin/activate (Linux/Mac) or venv\\Scripts\\activate (Windows)")
        print("  4. Install dependencies: pip install -r 01-core/requirements.txt")
        print("  5. Start development: python 01-core/main.py")
    elif project_type in ["node", "react"]:
        print("  2. Install dependencies: cd 01-core && npm install")
        print("  3. Start development: npm start")
    
    print("  📊 Generate status: Run status generation script")
    print("\n📖 See README.md for full instructions")
    
    return True

def create_web_files(name, description, author, email):
    """Create web project files"""
    
    # HTML file
    html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{description}">
    <meta name="author" content="{author}">
    <title>{name}</title>
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
            <h1>{name}</h1>
            <p class="subtitle">{description}</p>
            
            <div class="content-placeholder">
                <h2>Welcome to your new project!</h2>
                <p>This project was generated with the Universal Project Template Generator.</p>
                <p>Start editing this file to build your application.</p>
            </div>
        </section>

        <section id="section-2" class="section">
            <h2>Getting Started</h2>
            <div class="content-placeholder">
                <p>1. Edit files in the <code>01-core/</code> folder</p>
                <p>2. Add assets to <code>02-assets/</code></p>
                <p>3. Store data in <code>03-content/</code></p>
                <p>4. Document in <code>04-docs/</code></p>
                <p>5. Use utilities in <code>05-utilities/</code></p>
            </div>
        </section>

        <section id="section-3" class="section">
            <h2>Development Tools</h2>
            <div class="content-placeholder">
                <p>🚀 <strong>Start Server:</strong> Double-click <code>05-utilities/start-server.bat</code> (Windows)</p>
                <p>📊 <strong>Generate Status:</strong> Double-click <code>05-utilities/generate-status.bat</code> (Windows)</p>
                <p>🐍 <strong>Python Server:</strong> <code>python 05-utilities/scripts/serve.py</code></p>
            </div>
        </section>
    </main>

    <button class="back-to-top" id="back-to-top" aria-label="Back to top">↑</button>

    <footer class="main-footer">
        <div class="footer-content">
            <p>&copy; {datetime.now().year} {name}. Created by {author}</p>
        </div>
    </footer>

    <script src="script.js"></script>
</body>
</html>"""
    
    Path("01-core/index.html").write_text(html_content, encoding='utf-8')
    
    # CSS file (simplified from Project Ares)
    css_content = """/* Modern CSS Framework - Based on Project Ares architecture */

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
}"""
    
    Path("01-core/style.css").write_text(css_content, encoding='utf-8')
    
    # JavaScript file (simplified from Project Ares)
    js_content = f"""// {name} - Interactive JavaScript
// Based on Project Ares architecture

document.addEventListener('DOMContentLoaded', function() {{
    // Elements
    const navToggle = document.getElementById('nav-toggle');
    const stickyNav = document.getElementById('sticky-nav');
    const backToTop = document.getElementById('back-to-top');
    const progressFill = document.getElementById('progress-fill');

    // Navigation toggle
    if (navToggle && stickyNav) {{
        navToggle.addEventListener('click', function() {{
            navToggle.classList.toggle('active');
            stickyNav.classList.toggle('active');
        }});

        // Close navigation when clicking outside
        document.addEventListener('click', function(event) {{
            if (!stickyNav.contains(event.target) && !navToggle.contains(event.target)) {{
                navToggle.classList.remove('active');
                stickyNav.classList.remove('active');
            }}
        }});
    }}

    // Scroll progress indicator
    function updateProgressBar() {{
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
        const progress = (scrollTop / scrollHeight) * 100;
        
        if (progressFill) {{
            progressFill.style.width = Math.min(progress, 100) + '%';
        }}
    }}

    // Back to top functionality
    function updateBackToTop() {{
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (backToTop) {{
            if (scrollTop > 300) {{
                backToTop.classList.add('visible');
            }} else {{
                backToTop.classList.remove('visible');
            }}
        }}
    }}

    if (backToTop) {{
        backToTop.addEventListener('click', function() {{
            window.scrollTo({{
                top: 0,
                behavior: 'smooth'
            }});
        }});
    }}

    // Scroll handlers
    window.addEventListener('scroll', function() {{
        updateProgressBar();
        updateBackToTop();
    }});

    // Smooth scrolling for internal links
    document.querySelectorAll('a[href^="#"]').forEach(link => {{
        link.addEventListener('click', function(e) {{
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            if (targetElement) {{
                const offsetTop = targetElement.offsetTop - 80;
                window.scrollTo({{
                    top: offsetTop,
                    behavior: 'smooth'
                }});
                
                // Close navigation if open
                if (navToggle && stickyNav) {{
                    navToggle.classList.remove('active');
                    stickyNav.classList.remove('active');
                }}
            }}
        }});
    }});

    // Keyboard navigation
    document.addEventListener('keydown', function(e) {{
        if (e.key === 'Escape') {{
            if (navToggle && stickyNav) {{
                navToggle.classList.remove('active');
                stickyNav.classList.remove('active');
            }}
        }}
    }});

    // Initialize
    updateProgressBar();
    updateBackToTop();
    
    console.log('{name} initialized successfully');
}});"""
    
    Path("01-core/script.js").write_text(js_content, encoding='utf-8')

def create_python_files(name, description, author, email):
    """Create Python project files"""
    
    # Main Python file
    main_content = f'''# {name}
"""
{description}

Author: {author} <{email}>
Created: {datetime.now().strftime('%Y-%m-%d')}
"""

def main():
    """Main entry point for {name}."""
    print("Welcome to {name}")
    print("{description}")

if __name__ == "__main__":
    main()'''
    
    Path("01-core/main.py").write_text(main_content, encoding='utf-8')
    
    # Requirements file
    requirements_content = f"""# {name} Dependencies
# Add your Python packages here

# Common packages for most projects
requests>=2.28.0
numpy>=1.21.0
pandas>=1.4.0

# Development dependencies
pytest>=7.0.0
black>=22.0.0
flake8>=4.0.0"""
    
    Path("01-core/requirements.txt").write_text(requirements_content, encoding='utf-8')

def create_node_files(name, safe_name, description, author, email):
    """Create Node.js project files"""
    
    # Package.json
    package_json = {
        "name": safe_name.lower(),
        "version": "1.0.0",
        "description": description,
        "main": "index.js",
        "scripts": {
            "start": "node index.js",
            "dev": "nodemon index.js",
            "test": "jest",
            "lint": "eslint .",
            "format": "prettier --write ."
        },
        "keywords": ["project", "template"],
        "author": f"{author} <{email}>",
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
    
    with open("01-core/package.json", 'w') as f:
        json.dump(package_json, f, indent=2)
    
    # Main application file
    index_js = f'''// {name} - Node.js Application
// {description}

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
app.get('/', (req, res) => {{
    res.json({{
        name: '{name}',
        description: '{description}',
        author: '{author}',
        version: '1.0.0',
        status: 'running'
    }});
}});

app.get('/api/health', (req, res) => {{
    res.json({{ status: 'healthy', timestamp: new Date().toISOString() }});
}});

// Start server
app.listen(port, () => {{
    console.log(`🚀 {name} server running on port ${{port}}`);
    console.log(`📖 Open http://localhost:${{port}} in your browser`);
}});

module.exports = app;'''
    
    Path("01-core/index.js").write_text(index_js, encoding='utf-8')

def create_react_files(name, safe_name, description, author, email):
    """Create React project files"""
    
    # Create src and public directories
    Path("01-core/src").mkdir(exist_ok=True)
    Path("01-core/public").mkdir(exist_ok=True)
    
    # Package.json
    package_json = {
        "name": safe_name.lower(),
        "version": "1.0.0",
        "description": description,
        "private": True,
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
        "keywords": ["react", "project"],
        "author": f"{author} <{email}>",
        "license": "MIT",
        "browserslist": {
            "production": [">0.2%", "not dead", "not op_mini all"],
            "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]
        }
    }
    
    with open("01-core/package.json", 'w') as f:
        json.dump(package_json, f, indent=2)
    
    # App.js
    app_js = f'''import React from 'react';
import './App.css';

function App() {{
  return (
    <div className="App">
      <header className="App-header">
        <h1>{name}</h1>
        <p>{description}</p>
        <p>Created by: {author}</p>
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
}}

export default App;'''
    
    Path("01-core/src/App.js").write_text(app_js, encoding='utf-8')
    
    # App.css
    app_css = """.App {
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
}"""
    
    Path("01-core/src/App.css").write_text(app_css, encoding='utf-8')
    
    # index.js
    index_js = '''import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);'''
    
    Path("01-core/src/index.js").write_text(index_js, encoding='utf-8')
    
    # index.css
    index_css = '''body {
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
}'''
    
    Path("01-core/src/index.css").write_text(index_css, encoding='utf-8')
    
    # public/index.html
    public_html = f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="{description}" />
    <title>{name}</title>
</head>
<body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
</body>
</html>'''
    
    Path("01-core/public/index.html").write_text(public_html, encoding='utf-8')

def create_django_files(name, safe_name, description, author, email):
    """Create Django project files"""
    # Django project structure - simplified for template
    pass

def create_api_files(name, safe_name, description, author, email):
    """Create API project files"""
    # API project structure - simplified for template
    pass

def create_docs_files(name, description, author, email):
    """Create documentation project files"""
    # Documentation project structure - simplified for template
    pass

def create_readme(name, safe_name, project_type, description, author, email):
    """Create universal README file"""
    
    python_setup = ""
    if project_type == "python":
        python_setup = """

## Python Setup

1. Create virtual environment: `python -m venv venv`
2. Activate environment: `source venv/bin/activate` (Linux/Mac) or `venv\\Scripts\\activate` (Windows)
3. Install dependencies: `pip install -r 01-core/requirements.txt`
4. Run application: `python 01-core/main.py`"""
    
    node_setup = ""
    if project_type in ["node", "react"]:
        node_setup = """

## Node.js Setup

1. Install dependencies: `npm install` (in 01-core/ folder)
2. Start development: `npm run dev` or `npm start`
3. Build for production: `npm run build`"""
    
    readme_content = f"""# {name}

{description}

## 🚀 Quick Start

### Development
1. **Start development:** Run appropriate server for your platform
   - Windows: Double-click `05-utilities/start-server.bat`
   - Linux/Mac: `python 05-utilities/scripts/serve.py`
2. **Edit files:** Modify files in `01-core/` folder  
3. **Generate status:** Run status generation script

### Project Structure
```
{safe_name}/
├── 01-core/           # Main application files
├── 02-assets/         # Static assets (images, docs)
├── 03-content/        # Content and data files
├── 04-docs/           # Project documentation
└── 05-utilities/      # Development tools
    ├── start-server.bat      # 🖱️ Start development server (Windows)
    ├── generate-status.bat   # 🖱️ Generate project status (Windows)
    └── scripts/              # Utility scripts
        ├── serve.py          # Python dev server
        └── repo-status/      # Status generation tools
```

## 📊 Project Status

Run status generation scripts to create comprehensive project reports perfect for sharing with AI assistants.

## 👨‍💻 Development

- **Project Type:** {project_type}
- **Author:** {author}
- **Email:** {email}
- **Created:** {datetime.now().strftime('%Y-%m-%d')}
{python_setup}{node_setup}

---

*Generated with Universal Project Template Generator based on Project Ares architecture*"""
    
    Path("README.md").write_text(readme_content, encoding='utf-8')

def create_utilities(name, safe_name, project_type, author, email):
    """Create development utilities"""
    
    # Python server script (universal)
    serve_py = f'''#!/usr/bin/env python3
"""
Simple development server for {name}
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
            print(f"🚀 {name} Development Server")
            print(f"📂 Serving directory: {{DIRECTORY}}")
            print(f"🌐 Server running at: http://localhost:{{PORT}}")
            print(f"⭐ Press Ctrl+C to stop the server")
            
            try:
                webbrowser.open(f"http://localhost:{{PORT}}")
                print(f"🌟 Browser opened automatically")
            except:
                print(f"💡 Please manually open: http://localhost:{{PORT}}")
            
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print(f"\\n🛑 Server stopped by user")
    except OSError as e:
        if e.errno == 48:
            print(f"❌ Port {{PORT}} is already in use")
        else:
            print(f"❌ Error starting server: {{e}}")

if __name__ == "__main__":
    main()'''
    
    Path("05-utilities/scripts/serve.py").write_text(serve_py, encoding='utf-8')
    
    # Status generator script (simplified)
    status_script = f'''#!/usr/bin/env python3
"""
Repository Status Generator for {name}
Generates comprehensive project snapshot
"""

import os
import subprocess
from datetime import datetime
from pathlib import Path

def generate_status():
    """Generate project status report"""
    
    output_file = "05-utilities/scripts/repo-status/repo_status_{safe_name.lower().replace('-', '_')}.txt"
    date = datetime.now().strftime("%a, %b %d, %Y %I:%M:%S %p")
    
    with open(output_file, 'w') as f:
        f.write(f"""==============================
{name.upper()} – REPO SNAPSHOT  
Generated: {date}
==============================

[PROJECT OVERVIEW]
Project: {name}
Type: {project_type}
Description: Generated project
Author: {author}
Created: {datetime.now().strftime('%Y-%m-%d')}

[CORE PROJECT FILES STATUS]
""")
        
        # Check core files
        core_files = list(Path("01-core").rglob("*"))
        if core_files:
            f.write("[CORE APPLICATION FILES - 01-core]\\n")
            for file in core_files:
                if file.is_file():
                    size_kb = round(file.stat().st_size / 1024, 1)
                    f.write(f"PASS {{file.relative_to('.')}} - {{size_kb}}KB\\n")
        
        # Check project structure
        f.write("\\n[PROJECT STRUCTURE]\\n")
        directories = ["01-core", "02-assets", "03-content", "04-docs", "05-utilities"]
        for dir_name in directories:
            if Path(dir_name).exists():
                count = len(list(Path(dir_name).rglob("*")))
                f.write(f"PASS {{dir_name}}\\\\ - {{count}} items\\n")
            else:
                f.write(f"FAIL {{dir_name}}\\\\ - MISSING\\n")
        
        # Git status if available
        f.write("\\n[GIT STATUS]\\n")
        try:
            result = subprocess.run(["git", "status", "--short"], 
                                  capture_output=True, text=True, check=True)
            if result.stdout.strip():
                f.write("Working directory changes:\\n")
                f.write(result.stdout)
            else:
                f.write("Working directory: CLEAN\\n")
        except (subprocess.CalledProcessError, FileNotFoundError):
            f.write("Not a git repository or git not available\\n")
        
        f.write(f"""
[SUMMARY]
Project: {name}
Type: {project_type}
Status: Ready for development
Generated: {output_file}
Ready to share with AI assistants!
""")
    
    print(f"✅ Status report generated: {output_file}")

if __name__ == "__main__":
    generate_status()'''
    
    Path("05-utilities/scripts/repo-status/generate_status.py").write_text(status_script, encoding='utf-8')
    
    # Windows batch files
    if os.name == 'nt' or True:  # Create for all platforms
        start_server_bat = f"""@echo off
title {name} - Development Server
color 0B
echo.
echo ================================================
echo   {name.upper()} - DEVELOPMENT SERVER  
echo ================================================
echo.
cd /d "%~dp0\\.."
"""
        
        if project_type == "web":
            start_server_bat += """if exist "05-utilities\\scripts\\serve.py" (
    python "05-utilities\\scripts\\serve.py"
) else (
    echo Starting basic file server...
    if exist "01-core\\index.html" (
        start "" "01-core\\index.html"
    ) else (
        echo Open files in 01-core/ folder to get started
    )
)"""
        elif project_type == "python":
            start_server_bat += """echo Starting Python application...
cd 01-core
if exist "venv\\Scripts\\activate.bat" (
    call venv\\Scripts\\activate.bat
    python main.py
) else (
    echo Warning: Virtual environment not found
    echo Run: python -m venv venv
    echo Then: venv\\Scripts\\activate
    echo Then: pip install -r requirements.txt
    python main.py
)"""
        elif project_type in ["node", "react"]:
            start_server_bat += """echo Starting Node.js application...
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
)"""
        
        start_server_bat += """
pause"""
        
        Path("05-utilities/start-server.bat").write_text(start_server_bat, encoding='utf-8')
        
        # Status generation batch
        status_bat = f"""@echo off
title {name} - Repository Status
color 0E
echo.
echo ================================================
echo   {name.upper()} - REPOSITORY STATUS
echo ================================================
echo.
cd /d "%~dp0\\.."
python "05-utilities\\scripts\\repo-status\\generate_status.py"
echo.
echo Status report generated!
choice /C YN /M "Open the status report now"
if errorlevel 2 goto end
if exist "05-utilities\\scripts\\repo-status\\repo_status_{safe_name.lower().replace('-', '_')}.txt" (
    start notepad "05-utilities\\scripts\\repo-status\\repo_status_{safe_name.lower().replace('-', '_')}.txt"
)
:end
pause"""
        
        Path("05-utilities/generate-status.bat").write_text(status_bat, encoding='utf-8')

def create_gitignore(project_type):
    """Create appropriate .gitignore file"""
    
    gitignore_content = ""
    
    if project_type == "web":
        gitignore_content = """# Web Project .gitignore
node_modules/
*.log
.env
.DS_Store
Thumbs.db
dist/
build/"""
    
    elif project_type == "python":
        gitignore_content = """# Python Project .gitignore
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
Thumbs.db"""
    
    elif project_type in ["node", "react"]:
        gitignore_content = """# Node.js Project .gitignore
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
Thumbs.db"""
    
    if gitignore_content:
        Path(".gitignore").write_text(gitignore_content, encoding='utf-8')

def main():
    parser = argparse.ArgumentParser(description="Universal Project Template Generator")
    parser.add_argument("name", help="Project name")
    parser.add_argument("--type", choices=["web", "python", "node", "react", "django", "api", "docs"], 
                       default="web", help="Project type")
    parser.add_argument("--description", default="", help="Project description")
    parser.add_argument("--author", default=os.getenv('USER', 'Your Name'), help="Author name")
    parser.add_argument("--email", default="your.email@example.com", help="Author email")
    parser.add_argument("--path", default=".", help="Output path")
    parser.add_argument("--git", action="store_true", help="Initialize git repository")
    
    args = parser.parse_args()
    
    success = create_project(
        name=args.name,
        project_type=args.type,
        description=args.description,
        author=args.author,
        email=args.email,
        path=args.path,
        git=args.git
    )
    
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
