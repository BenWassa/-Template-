# Universal Project Template Generator - Installation & Usage Guide

## 🚀 Quick Installation

### Option 1: Automated Setup (Recommended)
```bash
# Windows
.\setup.ps1

# Linux/Mac  
./setup.sh
```

### Option 2: Manual Setup
1. Ensure Python 3.6+ is installed
2. Clone/download this repository
3. You're ready to go!

## 💻 Usage Examples

### Simple Project Creation
```bash
# Create a basic website
python create-project-fixed.py "My Website"

# Create a Python project
python create-project-fixed.py "Data Analysis" --type python

# Create a React app with Git
python create-project-fixed.py "Task Manager" --type react --git
```

### Full Option Examples
```bash
# Complete web project setup
python create-project-fixed.py "Portfolio Site" \
    --type web \
    --description "Personal portfolio and blog" \
    --author "John Doe" \
    --email "john@example.com" \
    --git

# Node.js API project
python create-project-fixed.py "User API" \
    --type node \
    --description "RESTful user management API" \
    --author "Jane Smith" \
    --git
```

### Windows Batch Alternative
```cmd
# Simple usage
create-project.bat "My Project" web "Project description"

# The batch file automatically tries PowerShell first, then falls back to Python
```

## 📁 Project Types Available

| Type | Language/Framework | Best For |
|------|-------------------|-----------|
| `web` | HTML5, CSS3, JS | Static sites, portfolios, landing pages |
| `python` | Python 3 | Scripts, automation, data science |
| `node` | Node.js + Express | APIs, servers, microservices |
| `react` | React 18 | SPAs, dashboards, web apps |
| `django` | Django | Full-stack web applications |
| `api` | FastAPI/Express | REST APIs, backend services |
| `docs` | Markdown | Documentation sites |

## 🛠️ Generated Development Tools

Every project includes these utilities:

### Windows
- `05-utilities\start-server.bat` - One-click development server
- `05-utilities\generate-status.bat` - Project status report

### Cross-Platform Scripts
- `05-utilities/scripts/serve.py` - Python development server
- `05-utilities/scripts/serve.ps1` - PowerShell development server  
- `05-utilities/scripts/repo-status/generate_status.py` - Status generator

## 🔧 Development Workflow

### 1. Create Project
```bash
python create-project-fixed.py "My App" --type react --git
cd My-App
```

### 2. Start Development
```bash
# Web projects
python 05-utilities/scripts/serve.py

# Node/React projects  
cd 01-core && npm install && npm start

# Python projects
cd 01-core && python -m venv venv && venv\Scripts\activate && pip install -r requirements.txt
```

### 3. Generate Status Reports
```bash
python 05-utilities/scripts/repo-status/generate_status.py
```
Perfect for sharing project state with AI assistants!

## 📊 Status Reports Include

- **Project Overview**: Name, type, description, author
- **File Structure**: Complete directory tree with file counts
- **Code Metrics**: Line counts for source files
- **Git Information**: Branch, commits, working directory status
- **Health Checks**: Project-specific validation
- **Development Tools**: Available utilities and scripts

## 🎯 Project Structure Explained

```
your-project/
├── 01-core/              # Main application code
│   ├── index.html        # (Web) Entry point
│   ├── main.py          # (Python) Main script
│   ├── package.json     # (Node/React) Dependencies
│   └── src/             # (React) Components
├── 02-assets/           # Static resources
│   ├── images/          # Image files
│   └── docs/            # Asset documentation
├── 03-content/          # Data and content
│   └── data/            # JSON, CSV, etc.
├── 04-docs/             # Project documentation
│   └── specs/           # Specifications
└── 05-utilities/        # Development tools
    ├── start-server.bat     # Windows dev server
    ├── generate-status.bat  # Windows status gen
    └── scripts/             # Cross-platform tools
```

## 🌟 Best Practices

### For AI-Assisted Development
1. **Generate status regularly**: `python 05-utilities/scripts/repo-status/generate_status.py`
2. **Share the report**: Perfect context for LLMs like ChatGPT, Claude, etc.
3. **Use consistent structure**: Makes AI assistance more effective

### For Team Development
1. **Standardize with templates**: Everyone uses the same structure
2. **Version control utilities**: Include development scripts in Git
3. **Document project-specific setup**: Add details to 04-docs/

### For Production Readiness
1. **Web projects**: Use `01-core/` as your build source
2. **Python projects**: Package from `01-core/` with proper `setup.py`
3. **Node/React**: Build from `01-core/` to `dist/` or `build/`

## 🚨 Troubleshooting

### PowerShell Execution Policy
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Python Not Found
- Install Python 3.6+ from python.org
- Ensure Python is in your PATH
- Use `python3` instead of `python` on some systems

### Git Not Initialized
Add Git manually:
```bash
cd your-project
git init
git add .
git commit -m "Initial commit"
```

### Port Already in Use
The development server will try different ports automatically, or specify one:
```bash
python 05-utilities/scripts/serve.py --port 8080
```

## 📚 Advanced Usage

### Custom Templates
Modify `create-project-fixed.py` to add new project types:

```python
# Add to the project_types dictionary
"custom": {
    "description": "Custom project type",
    "files": {
        "01-core/main.ext": "Your template content"
    }
}
```

### Environment Variables
Set defaults:
```bash
export TEMPLATE_DEFAULT_AUTHOR="Your Name"
export TEMPLATE_DEFAULT_EMAIL="your@email.com"
export TEMPLATE_DEFAULT_TYPE="web"
```

### CI/CD Integration
```yaml
# GitHub Actions example
- name: Generate Project
  run: |
    python create-project-fixed.py "${{ github.event.inputs.project_name }}" \
      --type "${{ github.event.inputs.project_type }}" \
      --git
```

## 🎉 You're Ready!

The Universal Project Template Generator is now fully operational. Start creating structured, professional projects in seconds:

```bash
python create-project-fixed.py "Amazing Project" --type web --git
```

Happy coding! 🚀
