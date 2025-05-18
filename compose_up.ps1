#!/usr/bin/env pwsh
# Enable BuildKit and the Compose CLI builder
$Env:DOCKER_BUILDKIT          = "1"
$Env:COMPOSE_DOCKER_CLI_BUILD = "1"

# Build images and start services
docker compose build
docker compose up -d
# Wait for the services to be ready
Start-Sleep -Seconds 10
# Display the status of the services
docker compose ps
# Display the logs of the services
docker compose logs --tail 50 --follow