#!/usr/bin/env bash
set -e

echo "Inicializando submódulos..."
git submodule init

echo "Actualizando submódulos..."
git submodule update

echo "Configurando submódulo backend para usar la rama feat/prueba..."
cd backend
git checkout feat/prueba
git pull origin feat/prueba
cd ..

echo "Configurando submódulo frontend para usar la rama feature/cambios..."
cd frontend
git checkout feature/cambios
git pull origin feature/cambios
cd ..

echo "Configuración completada. Los submódulos están ahora en las ramas correctas."
echo "Puedes ejecutar ./compose_up.sh o ./macos_compose_up.sh para iniciar los servicios."
