#!/usr/bin/env python3
"""
Repository Status Generator for Batch-Test
Generates comprehensive project snapshot
"""

import os
import subprocess
from datetime import datetime
from pathlib import Path

def generate_status():
    """Generate project status report"""
    
    output_file = "05-utilities/scripts/repo-status/repo_status_batch_test.txt"
    date_str = datetime.now().strftime("%a, %b %d, %Y %I:%M:%S %p")
    
    with open(output_file, 'w') as f:
        f.write(f"""==============================
BATCH-TEST – REPO SNAPSHOT  
Generated: {date_str}
==============================

[PROJECT OVERVIEW]
Project: Batch-Test
Type: web
Description: Testing the batch wrapper
Author: benjamin.haddon
Created: 2025-07-14

[CORE PROJECT FILES STATUS]
""")
        
        # Check core files
        if Path("01-core").exists():
            core_files = list(Path("01-core").rglob("*"))
            f.write("[CORE APPLICATION FILES - 01-core]\n")
            for file in core_files:
                if file.is_file():
                    try:
                        size_kb = round(file.stat().st_size / 1024, 1)
                        f.write(f"PASS {file.relative_to('.')} - {size_kb}KB\n")
                    except:
                        f.write(f"PASS {file.relative_to('.')} - Unknown size\n")
        
        # Check project structure
        f.write("\n[PROJECT STRUCTURE]\n")
        directories = ["01-core", "02-assets", "03-content", "04-docs", "05-utilities"]
        for dir_name in directories:
            if Path(dir_name).exists():
                try:
                    count = len(list(Path(dir_name).rglob("*")))
                    f.write(f"PASS {dir_name}\\ - {count} items\n")
                except:
                    f.write(f"PASS {dir_name}\\ - Directory exists\n")
            else:
                f.write(f"FAIL {dir_name}\\ - MISSING\n")
        
        # Git status if available
        f.write("\n[GIT STATUS]\n")
        try:
            result = subprocess.run(["git", "status", "--short"], 
                                  capture_output=True, text=True, check=True)
            if result.stdout.strip():
                f.write("Working directory changes:\n")
                f.write(result.stdout)
            else:
                f.write("Working directory: CLEAN\n")
        except (subprocess.CalledProcessError, FileNotFoundError):
            f.write("Not a git repository or git not available\n")
        
        f.write(f"""
[SUMMARY]
Project: Batch-Test
Type: web
Status: Ready for development
Generated: {output_file}
Ready to share with AI assistants!
""")
    
    print(f"✅ Status report generated: {output_file}")

if __name__ == "__main__":
    generate_status()