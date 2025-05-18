#!/usr/bin/env bash
set -e

# Enable BuildKit and the Compose CLI builder
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

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