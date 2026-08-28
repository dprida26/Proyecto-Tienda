# Render Configuration Options

Hay 3 formas de configurar el deploy en Render. Elige la que mejor funcione:

## OPCIÓN 1: Docker (Recomendado)
**Ventajas:** Control total, resuelve todos los problemas

**En Render Dashboard:**
1. Busca donde dice "Node.js" o "Runtime"
2. Cambia a "Docker"
3. Asegúrate que "Dockerfile path" sea `./Dockerfile`
4. Click en "Rebuild"

**Nuestro Dockerfile:**
- Instala dependencias correctamente
- Verifica que tailwindcss esté presente
- Multi-stage build optimizado
- Incluye health check

---

## OPCIÓN 2: Node.js + Build Script
**Ventajas:** Si Docker no está disponible

**En Render Dashboard:**
1. Build Command: `bash build.sh`
2. Start Command: `npm start` (pero ajustar a `cd tienda-frontend && npm start`)
3. Root Directory: dejar en blanco o `/` (raíz)
4. Click en "Rebuild"

**Nuestro script de build:**
- Ejecuta `npm ci --legacy-peer-deps` en tienda-frontend
- Verifica que tailwindcss esté instalado
- Genera logs para debugging
- Ejecuta `npm run build` con NODE_OPTIONS

---

## OPCIÓN 3: Node.js + render.yaml
**Ventajas:** Configuración declarativa

**En Render Dashboard:**
1. Asegúrate que esté leyendo `render.yaml`
2. El archivo debería tener:
   ```yaml
   services:
     - type: web
       name: tienda-frontend
       runtime: node
       buildCommand: bash build.sh
       startCommand: cd tienda-frontend && npm start
   ```

---

## ¿CUÁL ELEGIR?

### Intenta OPCIÓN 1 (Docker) primero
Si aparece opción para cambiar runtime:
- Cambiar a Docker
- Usar nuestro Dockerfile

### Si Docker no está disponible, usa OPCIÓN 2
- Actualizar Build Command: `bash build.sh`
- Actualizar Start Command: `cd tienda-frontend && npm start`

### OPCIÓN 3 es para si Render lee render.yaml automáticamente

---

## PROBLEMA ACTUAL

El error persiste porque Render está usando Node.js y NOT está usando `render.yaml` ni Dockerfile.

Por eso buscaba en `/opt/render/project/src/tienda-frontend/` en lugar de `/opt/render/project/tienda-frontend/`

**SOLUCIÓN:** Cambia a Docker o actualiza los comandos en el dashboard de Node.js
