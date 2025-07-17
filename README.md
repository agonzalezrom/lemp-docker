# LEMP Docker Stack

A modern, optimized LEMP stack (Linux, Nginx, MariaDB, PHP) using Docker for Laravel, Symfony, and other PHP applications.

## 🚀 Features

- **PHP 8.4** with FPM on Alpine Linux
- **Nginx 1.27** (Alpine-based)
- **MariaDB 11.6** (Latest LTS)
- **Xdebug 3** properly configured
- Optimized for development with hot-reload
- Multi-stage Dockerfile for smaller images
- Non-root user for enhanced security

## 📋 Requirements

- Docker
- Docker Compose

## ⚙️ Configuration

Edit the `.env` file with your project settings:

```env
APP_NAME=my-project
MYSQL_DATABASE=default
MYSQL_ROOT_PASSWORD=default
MYSQL_PORT=3306
NGINX_PORT=80
XDEBUG_PORT=9003
XDEBUG_REMOTE_HOST=host.docker.internal
WORK_DIRECTORY=/path/to/your/workspace
```

## 🛠️ Usage

### Start the stack
```bash
docker-compose up -d
```

### Stop the stack
```bash
docker-compose down
```

### Access PHP container
```bash
docker exec -it <app_name>-php sh
```

### Create a new project
Once inside the PHP container:

```bash
# Symfony
composer create-project symfony/skeleton .

# Laravel
composer create-project laravel/laravel .
```

### View logs
```bash
docker-compose logs -f
```

## 🔧 Services

| Service | Container Name | Port | Description |
|---------|---------------|------|-------------|
| PHP | `{APP_NAME}-php` | 9000 | PHP 8.4 FPM |
| Nginx | `{APP_NAME}-nginx` | `{NGINX_PORT}` | Web server |
| MariaDB | `{APP_NAME}-mariadb` | `{MYSQL_PORT}` | Database |

## 🐛 Xdebug Configuration

Xdebug is pre-configured for PHPStorm/VSCode:

- **Port**: 9003 (Xdebug 3 default)
- **IDE Key**: PHPSTORM
- **Client Host**: host.docker.internal

### PHPStorm Setup
1. Go to Settings → PHP → Servers
2. Add server with Host: `localhost`, Port: `{NGINX_PORT}`
3. Enable "Use path mappings"
4. Map your project folder to `/var/www/html`

## 📁 Directory Structure

```
.
├── config/
│   ├── nginx/          # Nginx configuration
│   └── php/            # PHP configuration
├── project/            # Your application code
├── docker-compose.yml
├── Dockerfile
└── .env
```

## 🔄 Updates

This configuration uses:
- PHP 8.4 (latest stable)
- Nginx 1.27-alpine
- MariaDB 11.6 (LTS)
- Docker Compose 3.8

## 📝 Notes

- Database data persists in a Docker volume
- Project files are mounted for live development
- Container runs as non-root user (www:1000)
- Optimized for both development and production builds
