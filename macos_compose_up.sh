#!/usr/bin/env bash
set -e

# Configurar submódulos para usar las ramas correctas
echo "Configurando submódulos para usar las ramas específicas..."
./setup_modules.sh

# Enable BuildKit and the Compose CLI builder
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDX_BUILDER=container

# Create private builder if it doesn't exist
if ! docker buildx inspect mybuilder &>/dev/null; then
    echo "Creating a new Docker Buildx builder named 'mybuilder'..."
    docker buildx create --name mybuilder --use
else
    echo "Using existing Docker Buildx builder 'mybuilder'."
fi

# Build images and start services
docker compose build
docker compose up -d
# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Check if the services are running
if docker compose ps | grep -q "Up"; then
    echo "Services are running successfully."
else
    echo "There was an issue starting the services."
    exit 1
fi
