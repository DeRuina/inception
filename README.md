# Inception Project

## Overview

Inception is a project that demonstrates the use of Docker Compose to set up a development environment for a WordPress site with Nginx and MariaDB. This setup is ideal for developers looking to work on WordPress projects locally without the need for a traditional LAMP stack.

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Clone the repository:
```bash
git clone https://github.com/DeRuina/inception.git
```
2. Navigate to the project directory:
```bash
cd inception
```
3. Run the application:
```bash
sudo make
```
4. Accessing the Application (In your web browser):
```bash
https://druina.42.fr
```
## Services

- **Nginx**: Acts as a reverse proxy for the WordPress application.
- **WordPress**: The main application.
- **MariaDB**: The database used by WordPress.

## Volumes

- `wordpress-data`: Persists WordPress data.
- `mariadb-data`: Persists MariaDB data.

## Networks

- `inception`: A custom network for the containers to communicate.


