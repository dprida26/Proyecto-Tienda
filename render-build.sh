#!/bin/bash
set -e

echo "=== Tienda Frontend Build Script ==="
echo "Node version: $(node --version)"
echo "NPM version: $(npm --version)"

echo "Installing dependencies..."
npm ci --prefer-offline --no-audit 2>&1

echo "Verifying tailwindcss installation..."
ls -la node_modules/tailwindcss/package.json 2>&1 || echo "⚠️  tailwindcss not found in node_modules"

echo "Running Next.js build..."
export NODE_OPTIONS="--max-old-space-size=2048"
npm run build

echo "=== Build completed successfully ==="
