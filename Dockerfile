# Multi-stage build for Tienda Frontend

# Build stage
FROM node:24-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Copy tienda-frontend directory
COPY tienda-frontend/ ./tienda-frontend/

# Change to tienda-frontend and install dependencies
WORKDIR /app/tienda-frontend

# Install all dependencies (including dev for build)
RUN npm ci --legacy-peer-deps 2>&1

# Verify tailwindcss is installed
RUN ls -la node_modules/tailwindcss/package.json || echo "WARNING: tailwindcss not found"

# Build Next.js application
RUN npm run build 2>&1

# Production stage - optimized image
FROM node:24-alpine

WORKDIR /app

# Copy only necessary files from builder
COPY package.json package-lock.json ./
COPY --from=builder /app/tienda-frontend ./tienda-frontend

# Install production dependencies only
WORKDIR /app/tienda-frontend
RUN npm ci --legacy-peer-deps --omit=dev --omit=optional 2>&1

# Expose port 3000
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Start the application
CMD ["npm", "start"]
