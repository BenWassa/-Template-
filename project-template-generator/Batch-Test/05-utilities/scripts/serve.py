#!/usr/bin/env python3
"""
Simple development server for Batch-Test
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
            print(f"🚀 Batch-Test Development Server")
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