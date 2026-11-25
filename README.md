# CareSync — Sistema de Inventario Hospitalario (Hospital San Rafael)

Aplicación web para el registro, consulta y control de camas de hospitalización, terminales de admisiones, estaciones de enfermería y equipo médico del **Hospital San Rafael**. Desarrollada con **Python/Flask**, **MySQL 8.4** y **Nginx**, orquestada con **Docker Compose** y validada mediante integración continua en **Jenkins**.

---

## Arquitectura del Sistema

* **`nginx` (`inventario-nginx-1`):** Proxy inverso que recibe las peticiones HTTP en el puerto `80` y las redirige a la aplicación.
* **`app` (`inventario-app-1`):** Backend en Python/Flask que gestiona la lógica de inventario y las vistas web.
* **`db` (`inventario-db-1`):** Base de datos MySQL `8.4` con almacenamiento persistente y verificación de estado (*healthcheck*).
* **Red interna:** Red aislada en Docker para la comunicación privada entre `nginx`, `app` y `db`.

## Estructura del Proyecto

```text
inventario-caresync/
├── app/              # Código fuente de la aplicación Flask y Dockerfile
├── db/               # Scripts de inicialización de MySQL
├── nginx/            # Configuración del proxy inverso
├── .env.example      # Plantilla de variables de entorno (sin contraseñas reales)
├── .gitignore        # Archivos excluidos del repositorio (incluye .env)
├── compose.yaml      # Orquestación de contenedores con Docker Compose
├── Jenkinsfile       # Pipeline de integración continua
└── README.md         # Documentación del proyecto
```

## Requisitos Previos

* **Docker** y **Docker Compose** instalados y en ejecución.
* Puerto `80` disponible en el equipo o servidor.

---

## Pasos para Recrear el Sistema

### 1. Obtener los archivos del proyecto
Descarga el código directamente desde GitHub haciendo clic en el botón **Code** > **Download ZIP** y descomprime la carpeta en tu equipo o servidor (o copia la carpeta completa `inventario-caresync` si ya la tienes en local).

### 2. Abrir una terminal en la carpeta del proyecto
Navega hasta la raíz del directorio descomprimido, donde se encuentra el archivo `compose.yaml`:

```bash
cd inventario-caresync
```

### 3. Crear y configurar el archivo `.env`
Crea una copia de la plantilla `.env.example` llamada `.env`:

* **En Linux / macOS:**
  ```bash
  cp .env.example .env
  ```
* **En Windows (CMD / PowerShell):**
  ```powershell
  copy .env.example .env
  ```

Abre el archivo `.env` con cualquier editor de texto y reemplaza las contraseñas de ejemplo por las que vayas a utilizar:

```env
MYSQL_ROOT_PASSWORD=CambiaEstaClaveRoot
MYSQL_DATABASE=inventario
MYSQL_USER=app_inventario
MYSQL_PASSWORD=CambiaEstaClaveApp

ORGANIZACION=Hospital San Rafael
```

### 4. Construir y levantar los contenedores
Ejecuta Docker Compose en segundo plano para construir las imágenes e iniciar los servicios:

```bash
docker compose up -d --build
```

### 5. Verificar que los servicios estén activos
Comprueba que los tres contenedores estén corriendo y que `db` aparezca como `healthy`:

```bash
docker compose ps
```

### 6. Acceder a la aplicación
Abre tu navegador web e ingresa a:
* **En local:** `http://localhost`
* **En servidor remoto:** `http://<IP_DEL_SERVIDOR>`

---

## Respaldo y Restauración de la Base de Datos

### Crear un respaldo (`mysqldump`)
```bash
mkdir -p ~/respaldos
docker exec inventario-db-1 mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --databases inventario > ~/respaldos/inventario_$(date +%F_%H%M).sql
```

### Restaurar un respaldo
```bash
docker exec -i inventario-db-1 mysql -u root -p"$MYSQL_ROOT_PASSWORD" < ~/respaldos/inventario_2026-11-17_1633.sql
```

## Detener el Sistema

Para apagar los contenedores sin perder los datos guardados en la base de datos:

```bash
docker compose down
```
