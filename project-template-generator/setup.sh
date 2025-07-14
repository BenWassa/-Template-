#!/bin/bash
# Universal Project Template Generator Setup Script (Linux/Mac)

echo "🚀 Setting up Universal Project Template Generator..."

# Make Python script executable
chmod +x create-project.py
chmod +x create-project-fixed.py

echo "✅ Made Python scripts executable"

# Test the installation
echo "🧪 Testing installation..."

if python3 --version > /dev/null 2>&1; then
    echo "✅ Python 3 found"
    
    # Test creating a sample project
    echo "📝 Creating test project..."
    python3 create-project-fixed.py "Test Project" --type web --description "Test project for validation" --author "Test User" --email "test@example.com"
    
    if [ -d "Test-Project" ]; then
        echo "✅ Test project created successfully!"
        echo "🧹 Cleaning up test project..."
        rm -rf "Test-Project"
    else
        echo "❌ Test project creation failed"
        exit 1
    fi
else
    echo "❌ Python 3 not found. Please install Python 3 first."
    exit 1
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📋 Usage:"
echo "  python3 create-project-fixed.py 'My Project' --type web --git"
echo "  python3 create-project-fixed.py 'Data Analysis' --type python --author 'Your Name'"
echo ""
echo "🎯 Available types: web, python, node, react"
echo "📖 See README.md for full documentation"
