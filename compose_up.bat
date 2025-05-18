@echo off
REM Enable BuildKit and the Compose CLI builder for this script
set "DOCKER_BUILDKIT=1"
set "COMPOSE_DOCKER_CLI_BUILD=1"

REM Build images and start services
docker compose build
docker compose up -d