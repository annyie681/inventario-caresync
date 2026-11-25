# CareSync — Sistema de Inventario Hospitalario (Hospital San Rafael)

Aplicación web para el registro, consulta y control de camas de hospitalización, terminales de admisiones, estaciones de enfermería y equipo médico del **Hospital San Rafael**. Desarrollada con **Python/Flask**, **MySQL 8.4** y **Nginx**, orquestada con **Docker Compose** y validada mediante integración continua en **Jenkins**.

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
