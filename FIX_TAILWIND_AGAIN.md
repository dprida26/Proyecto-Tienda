# Fix: Error de Tailwindcss en Render (Round 2)

## Problema Recurrente
**Error:** `Cannot find module 'tailwindcss'` en build de Render (2026-08-28)

El mismo error que parecía resuelto volvió a aparecer. Esto indica que:
1. Render **no estaba ejecutando `npm install` correctamente**
2. O **npm install se ejecutaba pero no guardaba los módulos**

## Causa Raíz
Render estaba buscando los archivos en `/opt/render/project/src/tienda-frontend/` en lugar de `/opt/render/project/tienda-frontend/`

Esto sugiere que Render no estaba interpretando correctamente la estructura del directorio y potencialmente no estaba instalando dependencias.

## Soluciones Aplicadas (2026-08-28)

### 1. Regenerar `package-lock.json`
```bash
cd tienda-frontend
rm -f package-lock.json npm-shrinkwrap.json
npm install
```
✅ Verificado: tailwindcss está en package-lock.json

### 2. Crear Script de Build Explícito
**Archivo:** `tienda-frontend/render-build.sh`
- Script que verifica la instalación de tailwindcss
- Ejecuta `npm ci` con flags explícitos
- Agrega logging para debugging

### 3. Crear `package.json` Raíz
**Archivo:** `Proyecto_Tienda/package.json`
- Define scripts que apuntan a `tienda-frontend/`
- Permite que Render use la raíz correctamente
- Fuerza que `npm run build` se ejecute en el directorio correcto

### 4. Actualizar `render.yaml`
```yaml
buildCommand: npm ci --legacy-peer-deps && npm run build
```
- Ahora usa el `package.json` raíz
- Agrega `--legacy-peer-deps` para evitar conflicts
- Más explícito sobre qué se debe ejecutar

### 5. Commit & Push
```
56bb951 - fix: agregar script de build explícito para Render
51cfb3b - fix: actualizar configuracion raiz para que Render instale dependencias
da07cf2 - chore: actualizar referencia de tienda-frontend
```

## ¿Qué Cambió?

| Antes | Ahora |
|-------|-------|
| Render usaba `render.yaml` con `rootDir: tienda-frontend` | Render usa `package.json` raíz con scripts que apuntan a tienda-frontend |
| No había script de build explícito | Hay `render-build.sh` para debugging |
| Posible que npm no instalara correctamente | `npm ci --legacy-peer-deps` es más explícito |

## Verificación Local
✅ Build funciona en 10+ segundos con el script
✅ tailwindcss está instalado correctamente
✅ 8 páginas generadas sin errores

## Próximo Paso
1. Ve a Render Dashboard
2. Cancela cualquier build en progreso
3. Haz click en "Rebuild"
4. Monitorea los logs:
   - Debería ver `npm ci --legacy-peer-deps`
   - Luego `npm run build`
   - Debería completarse en 30-40 segundos

## Si Sigue Fallando
Si el error persiste después de este fix, significa:
1. Render tiene un problema más profundo con la instalación
2. Podría ser necesario usar un `Dockerfile` personalizado
3. O considerar migrar a Vercel que tiene mejor soporte para Next.js

## Archivos Modificados
- ✅ `tienda-frontend/package-lock.json` - regenerado
- ✅ `tienda-frontend/render-build.sh` - creado
- ✅ `tienda-frontend/postcss.config.js` - sin cambios (verificado)
- ✅ `Proyecto_Tienda/package.json` - creado
- ✅ `Proyecto_Tienda/render.yaml` - actualizado
