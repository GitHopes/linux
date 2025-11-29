#!/bin/bash

# Actualizar lista de paquetes
echo "Actualizando paquetes..."
sudo apt update

# Actualizar paquetes instalados
echo "Actualizando sistema..."
sudo apt upgrade -y

# Instalar dependencias necesarias para usar repositorios HTTPS
echo "Instalando dependencias..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Agregar clave GPG oficial de Docker
echo "Agregando clave GPG de Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Agregar el repositorio oficial de Docker
echo "Agregando repositorio de Docker..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Actualizar nuevamente para cargar el nuevo repo
sudo apt update

# Instalar Docker Engine, CLI y containerd
echo "Instalando Docker..."
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Verificar estado del servicio Docker
echo "Verificando estado de Docker..."
sudo systemctl status docker

# Mostrar versión de Docker
docker --version

# Agregar tu usuario al grupo docker para no usar sudo
echo "Agregando usuario al grupo docker..."
sudo usermod -aG docker $USER

# Ejecutar contenedor de prueba
echo "Ejecutando contenedor hello-world..."
docker run hello-world

# Habilitar Docker al inicio del sistema
sudo systemctl enable docker

# Instalar Docker Compose
echo "Instalando Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Dar permisos de ejecución
echo "Haciendo docker-compose ejecutable..."
sudo chmod +x /usr/local/bin/docker-compose

# Ver versión de Docker Compose
docker-compose --version

echo "Instalación completada."
