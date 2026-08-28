#!/bin/bash
set -e

echo "=== Tienda Frontend Build Script for Render ==="
echo "Current directory: $(pwd)"
echo "Node version: $(node --version)"
echo "NPM version: $(npm --version)"

# Navigate to tienda-frontend
cd tienda-frontend

echo ""
echo "Step 1: Installing dependencies with npm ci..."
npm ci --legacy-peer-deps

echo ""
echo "Step 2: Verifying tailwindcss installation..."
if [ -f "node_modules/tailwindcss/package.json" ]; then
  echo "✓ tailwindcss found!"
  cat node_modules/tailwindcss/package.json | grep '"version"'
else
  echo "✗ ERROR: tailwindcss NOT found!"
  echo "Installed packages:"
  ls node_modules/ | grep -i tail || echo "No tailwind packages found"
  exit 1
fi

echo ""
echo "Step 3: Building Next.js app..."
export NODE_OPTIONS="--max-old-space-size=2048"
npm run build

echo ""
echo "=== Build completed successfully! ==="
echo "App is ready to start with: npm start"
