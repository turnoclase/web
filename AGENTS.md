# AGENTS.md — TurnoClase Web

## Descripción del repositorio

Sitio web estático del proyecto TurnoClase, generado con Jekyll y desplegado en Firebase Hosting. Incluye la página principal de la aplicación, la política de privacidad y páginas informativas para profesores, en inglés y español.

## Stack tecnológico

- **Generador:** Jekyll (Ruby)
- **Tema:** Minima
- **Internacionalización:** `jekyll-multiple-languages-plugin` (idiomas: `en`, `es`)
- **Hosting:** Firebase Hosting (proyecto `turnoclase-eu`)
- **Entorno local:** Docker (imagen custom con Ruby + Jekyll + Firebase CLI)
- **Automatización:** `make` + Docker Compose

## Estructura del repositorio

```
web/
├── Makefile                  # Comandos de build, serve y despliegue
├── Dockerfile                # Imagen Docker con Ruby/Jekyll y Firebase CLI
├── docker-compose.yml        # Servicio "node" para dev/deploy
├── firebase.json             # Configuración de Firebase Hosting
├── .firebaserc               # Proyecto Firebase activo (turnoclase-eu)
├── env-example               # Variables de entorno requeridas (copiar a .env)
└── jekyll/                   # Fuentes del sitio Jekyll
    ├── _config.yml           # Configuración de Jekyll
    ├── index.markdown        # Página de inicio
    ├── 01_teacher.markdown   # Página de información para profesores
    ├── 02_privacy.markdown   # Política de privacidad
    ├── 404.html              # Página de error 404
    ├── Gemfile               # Dependencias Ruby
    └── Gemfile.lock          # Versiones fijadas de gemas
```

## Comandos habituales

Todos los comandos se ejecutan desde la raíz del repositorio:

```bash
make build      # Construye la imagen Docker
make workspace  # Abre una shell dentro del contenedor (para tareas manuales)
make serve      # Servidor local de desarrollo en http://localhost:4000
make update     # Actualiza las gemas (bundle update) y genera commit automático
make deploy     # Genera el sitio estático y lo despliega en Firebase Hosting
make clean      # Elimina contenedores y volúmenes Docker
```

## Internacionalización

Las páginas se localizan mediante el plugin `jekyll-multiple-languages-plugin`. Las traducciones y variantes por idioma se gestionan dentro de cada fichero `.markdown` usando las convenciones del plugin. Las imágenes están excluidas de la localización (`exclude_from_localizations: ["images"]`).

## Convenciones

- Todo el contenido del sitio está en `jekyll/`. No modificar ficheros fuera de este directorio salvo `Makefile`, `Dockerfile` o `docker-compose.yml`.
- Los ficheros Markdown de páginas se nombran con prefijo numérico para controlar el orden (`01_`, `02_`).
- No hacer `bundle update` manualmente; usar `make update` para garantizar que el `Gemfile.lock` se actualiza dentro del contenedor correcto y se genera el commit.
- El fichero `.env` contiene variables de entorno sensibles; usar `env-example` como plantilla.

## Commits

Al completar cualquier característica o cambio, crear un commit con:

- **Mensaje en español**, en imperativo y conciso (p.ej. `Actualizar política de privacidad en inglés`).
- Un commit por característica o cambio cohesionado; no agrupar cambios no relacionados.
- No incluir el directorio `_site/` (build generado), `.jekyll-cache/` ni `.firebase/`.

## Consideraciones para agentes

- Para previsualizar cambios, usar `make serve` y verificar en el navegador antes de desplegar.
- El despliegue (`make deploy`) requiere autenticación con Firebase CLI (`firebase login`); no automatizar sin credenciales válidas.
- No modificar `Gemfile.lock` manualmente; regenerarlo siempre desde el contenedor Docker con `make update`.
- El proyecto Firebase de producción es `turnoclase-eu`; no cambiar el target sin autorización explícita.
- Los cambios en la política de privacidad (`02_privacy.markdown`) pueden tener implicaciones legales; revisar con el propietario antes de publicar.
