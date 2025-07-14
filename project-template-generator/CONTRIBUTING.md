# Contributing to Universal Project Template Generator

We welcome contributions! Here's how to help improve this project template system.

## 🎯 Ways to Contribute

### 1. Add New Project Types
Create templates for new frameworks and languages:
- **Django** - Python web framework
- **Vue.js** - Progressive JavaScript framework  
- **Angular** - TypeScript web applications
- **FastAPI** - Modern Python API framework
- **Go** - Go language projects
- **Rust** - Rust projects
- **.NET** - C# applications

### 2. Improve Existing Templates
- Better starter code
- More comprehensive utilities
- Enhanced status reporting
- Cross-platform compatibility

### 3. Platform Support
- **macOS** optimizations
- **Linux** distributions
- **Windows Subsystem for Linux (WSL)**
- **Docker** containerization

## 📁 Template Structure

Each project type should follow this pattern:

```
templates/
├── web/
│   ├── 01-core/
│   │   ├── index.html
│   │   ├── style.css
│   │   └── script.js
│   ├── template-config.json
│   └── README.md
├── python/
│   ├── 01-core/
│   │   ├── main.py
│   │   └── requirements.txt
│   ├── template-config.json
│   └── README.md
└── new-type/
    ├── 01-core/
    ├── template-config.json
    └── README.md
```

## 🛠️ Adding a New Project Type

### 1. Create Template Function

Add a new function in both scripts:

```powershell
# PowerShell (create-project.ps1)
"new-type" {
    # Create project-specific files
    @"
// New project type starter code
"@ | Out-File -FilePath "01-core/main.ext" -Encoding UTF8
}
```

```python
# Python (create-project.py)
def create_newtype_files(name, safe_name, description, author, email):
    """Create new project type files"""
    
    # Main file content
    main_content = f'''// {name} - New Project Type
// {description}'''
    
    Path("01-core/main.ext").write_text(main_content, encoding='utf-8')
```

### 2. Update Argument Validation

Add the new type to the choices list:

```powershell
[ValidateSet("web", "python", "node", "react", "new-type")]
```

```python
parser.add_argument("--type", choices=["web", "python", "node", "react", "new-type"])
```

### 3. Add Server Configuration

Update the batch files and server scripts to handle the new project type.

### 4. Create Documentation

Add usage examples and setup instructions for the new project type.

## 🧪 Testing New Templates

### Manual Testing
```bash
# Test your new template
python create-project.py "Test Project" --type new-type --git

# Verify structure
cd Test-Project
ls -la
./05-utilities/start-server.bat  # Windows
python 05-utilities/scripts/serve.py  # Linux/Mac
```

### Automated Testing
We welcome test scripts that validate:
- Project structure creation
- File content generation
- Development server functionality
- Status report generation

## 📋 Template Configuration

Use `template-config.json` to define template metadata:

```json
{
  "name": "New Project Type",
  "description": "Template for new project type",
  "version": "1.0.0",
  "requiredTools": ["node", "npm"],
  "optionalTools": ["git", "docker"],
  "defaultPort": 3000,
  "startCommand": "npm start",
  "buildCommand": "npm run build",
  "testCommand": "npm test"
}
```

## 🎨 Design Principles

### Consistency
- Follow the numbered folder structure (`01-core`, `02-assets`, etc.)
- Use Project Ares architecture patterns
- Maintain consistent naming conventions

### Cross-Platform Support
- Provide both PowerShell and Python implementations
- Test on Windows, macOS, and Linux
- Use platform-agnostic file paths

### Developer Experience
- One-click development server start
- Comprehensive status reporting
- Clear documentation and examples

### Scalability
- Templates should work for both small and large projects
- Support for additional configuration
- Extensible utility system

## 🔄 Submission Process

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b add-django-template`
3. **Implement** your changes following the patterns above
4. **Test** thoroughly on multiple platforms
5. **Document** your changes in README.md
6. **Submit** a pull request with:
   - Clear description of what you've added
   - Examples of usage
   - Testing results

## 📚 Resources

- **Project Ares** - Reference implementation
- **Cross-platform scripting** best practices
- **Modern web development** patterns
- **Development tooling** standards

## 💡 Ideas for Future Templates

- **Electron** desktop apps
- **Mobile apps** (React Native, Flutter)
- **Game development** (Unity, Godot)
- **Data science** notebooks
- **Machine learning** projects
- **Blockchain** applications
- **IoT** projects
- **Static site generators** (Jekyll, Hugo, Gatsby)

## 🤝 Questions?

- **Issues** - Use GitHub Issues for bugs and feature requests
- **Discussions** - Use GitHub Discussions for questions and ideas
- **Email** - Contact maintainers directly for sensitive issues

Thank you for helping make project setup faster and more consistent for everyone! 🚀
