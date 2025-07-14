# Universal Project Template Generator

A flexible, cross-platform system for creating structured projects with built-in development utilities and status reporting. Based on the proven Project Ares architecture.

## 🚀 Quick Start

### Super Simple - Just Double-Click
```
START-HERE.bat
```
The interactive menu will guide you through everything!

### Option 1: Python (Cross-Platform)
```bash
# Create new project
python core/create-project.py "My Website" --type web --author "Your Name" --git

# Or with full options  
python core/create-project.py "Data Analysis" --type python --description "ML project" --author "John Doe" --email "john@example.com" --git
```

### Option 2: Windows Batch File (Advanced)
```cmd
# Advanced usage
core/create-project.bat "My Website" web "A cool website"
```

## 📁 What You Get

Every generated project has this structure:
```
your-project/
├── 01-core/           # Main application files
├── 02-assets/         # Static assets (images, docs)
├── 03-content/        # Content and data files
├── 04-docs/           # Project documentation
└── 05-utilities/      # Development tools
    ├── start-server.bat      # 🖱️ Start development server
    ├── generate-status.bat   # 🖱️ Generate project status
    └── scripts/              # Utility scripts
        ├── serve.py          # Python dev server
        ├── serve.ps1         # PowerShell dev server
        └── repo-status/      # Status generation tools
```

## 🎯 Project Types

- **`web`** - HTML5/CSS3/JavaScript projects with development server
- **`python`** - Python projects with virtual environment setup
- **`node`** - Node.js projects with package.json and dependencies
- **`react`** - React projects with modern tooling
- **`django`** - Django web applications
- **`api`** - REST API projects
- **`docs`** - Documentation projects with static site generation

## ✨ Key Features

### 🔧 Development Tools
- **One-click server start** - Double-click `start-server.bat`
- **Instant status reports** - Double-click `generate-status.bat`
- **Cross-platform scripts** - Works on Windows, Mac, Linux

### 📊 Status Reporting
- Comprehensive project analysis
- Git status and commit history
- Code metrics and health checks
- Perfect for sharing with AI assistants

### 🎨 Project Structure
- **Numbered folders** for clear organization
- **Semantic naming** that scales with project growth
- **Consistent patterns** across all project types

### 🚀 Instant Setup
- Git initialization (optional)
- Proper .gitignore files
- Development dependencies
- README with project-specific instructions

## 📖 Usage Examples

### Web Project
```powershell
.\create-project.ps1 -Name "Company Website" -Type "web" -Description "Corporate site with portfolio" -Git
```
Creates: HTML5 starter, CSS framework, JavaScript modules, development server

### Python Data Science
```powershell
.\create-project.ps1 -Name "Sales Analysis" -Type "python" -Description "Q4 sales data analysis" -Git
```
Creates: Python project structure, requirements.txt, Jupyter integration

### Node.js API
```powershell
.\create-project.ps1 -Name "User API" -Type "node" -Description "REST API for user management" -Git
```
Creates: Express.js starter, package.json, API structure, testing setup

### React App
```powershell
.\create-project.ps1 -Name "Dashboard" -Type "react" -Description "Analytics dashboard" -Git
```
Creates: Modern React setup, component structure, routing, build tools

## 🔄 How It Works

1. **Template Selection** - Choose project type and provide details
2. **Structure Generation** - Creates numbered folder system
3. **File Population** - Generates appropriate starter files
4. **Customization** - Replaces placeholders with your project details
5. **Utility Setup** - Installs development and status tools
6. **Git Integration** - Optional repository initialization

## 📋 Command Reference

### Python Script (Primary)
```bash
python create-project.py "Project Name"
    --type web                  # Project type (web, python, node, react, django, api, docs)
    --description "Description" # Project description  
    --author "Your Name"        # Author name
    --email "your@email.com"    # Author email
    --git                       # Initialize git repository
    --path "/path/to/projects"  # Custom output path
```

### Windows Batch File
```cmd
create-project.bat "Project Name" [type] [description]
# Examples:
create-project.bat "My Website" web "A cool website"
create-project.bat "My API" node "REST API server"
```

## 🛠️ Installation

### Clone This Repository
```bash
git clone https://github.com/YourUsername/project-template-generator.git
cd project-template-generator
```

### Make Executable (Linux/Mac)
```bash
chmod +x create-project.py
chmod +x templates/*/scripts/*.sh
```

### Test Installation
```bash
# Cross-platform
python create-project.py "Test Project" --type web

# Windows batch
create-project.bat "Test Project" web "Testing the generator"
```

## 📚 Templates Included

Each project type includes:
- **Starter files** appropriate to the technology
- **Development server** configuration
- **Build/test scripts** where applicable
- **Documentation templates**
- **Git configuration** with appropriate .gitignore
- **Status reporting tools** for project tracking

## 🎯 Best Practices

### Project Naming
- Use descriptive names: "Sales Dashboard" not "Dashboard"
- Avoid special characters in project names
- Consider using semantic versioning for releases

### Development Workflow
1. **Create project** with template generator
2. **Start server** with double-click utility
3. **Develop iteratively** with live reload
4. **Generate status** regularly for tracking
5. **Share reports** with team/AI assistants

### Status Reporting
- Run status generation before major commits
- Share reports when asking for help
- Use reports to track project health over time

## 🤝 Contributing

We welcome contributions! Please see:
- Add new project types in `templates/` folder
- Improve existing templates
- Add platform-specific optimizations
- Enhance status reporting features

## 📄 License

MIT License - use freely for any projects

## 🙏 Acknowledgments

Based on the Project Ares architecture developed for digital humanities research. Special thanks to the structured approach to project organization that scales from simple websites to complex applications.

---

**Ready to create better projects faster?** Start with `python create-project.py "Your Project" --type web --git`
