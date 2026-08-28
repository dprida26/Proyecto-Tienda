# Deploy Tienda Frontend en Vercel

**Tiempo estimado:** 5-10 minutos  
**Dificultad:** ⭐ Muy fácil

---

## ¿Por qué Vercel?

- ✅ Soporte nativo para Next.js (es de los creadores)
- ✅ Deploy automático en cada push a GitHub
- ✅ Cero configuración necesaria
- ✅ HTTPS automático
- ✅ Dominio gratis (.vercel.app)
- ✅ Sin los problemas de Render

---

## Pasos para Deploy

### 1. Ir a Vercel

1. Abre https://vercel.com
2. Click en "Log In"
3. Selecciona "GitHub" (para conectar con tu cuenta)

### 2. Crear nuevo proyecto

1. Una vez loguado, click en "New Project"
2. Vercel te mostrará todos tus repos de GitHub
3. **Busca `tienda-electrodomesticos`**
4. Click en "Import"

### 3. Configurar el proyecto

**La pantalla mostrará algo como esto:**

```
Project Name:          [tienda-electrodomesticos]
Framework Preset:      Next.js  ← Detectado automáticamente ✅
Root Directory:        ./
```

**⚠️ CAMBIAR ROOT DIRECTORY a:**
```
tienda-frontend/
```

**Clickea en "Root Directory" y cambia a `tienda-frontend/`**

### 4. Variables de Entorno

**Agregá estas variables (opcional pero recomendado):**

| Key | Value |
|-----|-------|
| `NEXT_PUBLIC_API_URL` | `https://tienda-api-fr65.onrender.com` (o tu URL real) |

**Nota:** Si la API sigue con 400, déjalo por ahora. Vercel hace el deploy del frontend sin necesitar la API.

### 5. Deploy

1. Click en "Deploy"
2. Espera 2-3 minutos mientras Vercel:
   - Clona el repo
   - Detecta Next.js
   - Instala dependencias
   - Compila el proyecto
   - Despliega en la red CDN global

### 6. ¡Listo!

Una vez completado, Vercel te dará una URL como:
```
https://tienda-electrodomesticos.vercel.app
```

---

## Próximos Pasos (Automáticos)

Cada vez que hagas `git push` a `main`:
1. Vercel detecta el cambio automáticamente
2. Compila y deploya en ~1 minuto
3. Recibe una URL única para cada deploy

---

## Troubleshooting

### Si da error de build:
- Vercel mostrará logs claros en el dashboard
- Haz click en "View Log" para ver detalles
- Los logs de Vercel son mucho más claros que los de Render

### Si falta `tailwindcss`:
- No debería pasar (Vercel entiende Next.js)
- Si pasa, Vercel lo indicará claramente en los logs

---

## Volver a Render (si necesitas)

Si en el futuro quieres volver a Render:
- Solo eliminá este proyecto en Vercel
- Los archivos del repo permanecen igual
- Render seguirá funcionando normalmente

---

## Comparación: Vercel vs Render

| Aspecto | Vercel | Render |
|--------|--------|--------|
| **Next.js** | Nativo ⭐ | Problema |
| **Setup** | 1 click | Configuración manual |
| **Build time** | ~1 min | Variable (2-5 min) |
| **Logs** | Claros | Confusos |
| **Deploy automático** | ✅ | ✅ |
| **Costo** | Gratis | Gratis |

**Conclusión:** Para Next.js, Vercel es claramente superior.
