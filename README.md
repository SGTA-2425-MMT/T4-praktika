# CIVilizaTu Web Application

A turn-based strategy web game inspired by classic Civilization, developed for educational purposes. The project features a modern Angular frontend, a Python FastAPI backend, MongoDB for persistence, and GroQ-powered AI for single-player competition.

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Features](#features)
- [Setup & Deployment](#setup--deployment)
- [Development](#development)
- [API & Data Structures](#api--data-structures)
- [AI Integration](#ai-integration)
- [License](#license)

---

## Project Overview
- **Frontend:** Angular (TypeScript)
- **Backend:** FastAPI (Python)
- **Database:** MongoDB
- **AI:** GroQ LLM integration for AI opponent
- **Containerization:** Docker & Docker Compose
- **License:** GNU GPL v3

This project is for educational use only. All assets and code are original, public domain, or AI-generated and clearly marked as such.

## Architecture
```
+-----------+      +-----------+      +-----------+
| Frontend  |<---->|  Backend  |<---->|   AI Svc  |
| (Angular) |      | (FastAPI) |      |  (GroQ)   |
+-----------+      +-----------+      +-----------+
       |                 |                 |
       v                 v                 v
   +--------+        +--------+        +--------+
   | Mongo  |        |  LLM   |        |  ...   |
   +--------+        +--------+        +--------+
```
- **Frontend**: Angular SPA, communicates with backend via REST.
- **Backend**: FastAPI, handles game logic, user management, and AI orchestration.
- **MongoDB**: Stores users, games, and scenarios.
- **AI Service**: Connects to GroQ LLM for AI turns.

## Features
- User registration, authentication, and profiles
- Save/load games, scenario selection
- Turn-based gameplay: production, research, movement, diplomacy, building
- AI opponent powered by GroQ LLM
- Cheat code system for testing
- Dockerized deployment
- All assets (images, sounds) are original or AI-generated for educational use


## Cloning the Repository

This project uses git submodules for the `frontend` and `backend` directories. The frontend submódulo apunta a la rama `feature/cambios` y el backend a la rama `feat/prueba`.

Para clonar el repositorio e inicializar correctamente los submódulos con las ramas específicas, sigue estos pasos:

```bash
# Clonar el repositorio principal
git clone <repository-url>
cd <repository-directory>

# Ejecutar el script de configuración de submódulos
./setup_modules.sh
```

El script `setup_modules.sh` se encargará de:
1. Inicializar los submódulos
2. Cambiar cada submódulo a la rama correcta (frontend: feature/cambios, backend: feat/prueba)
3. Actualizar los submódulos con el contenido más reciente de esas ramas

Si prefieres hacerlo manualmente:

```bash
# Inicializar submódulos
git submodule init
git submodule update

# Configurar backend para usar la rama feat/prueba
cd backend
git checkout feat/prueba
git pull origin feat/prueba
cd ..

# Configurar frontend para usar la rama feature/cambios
cd frontend
git checkout feature/cambios
git pull origin feature/cambios
cd ..
```

## Setup & Deployment

### Prerequisites
- Docker & Docker Compose
- Node.js (for local frontend dev)
- Python 3.10+ (for local backend dev)

#### MongoDB (Optional)
If you do not use MongoDB Atlas, you can run a local MongoDB server. The backend expects `MONGODB_URI` to point to a running MongoDB instance (default: `mongodb://host.docker.internal:27017/civgame`).

**To install MongoDB locally:**

See the official installation instructions for your operating system at: https://www.mongodb.com/try/download/community

After installation, ensure the MongoDB service is running on port 27017.

### Environment Variables
Copia el archivo `.env.template` a un nuevo archivo llamado `.env`:

```bash
cp .env.template .env
```

Luego, edita el archivo `.env` para configurar las variables de entorno necesarias:

#### Variables Esenciales:

1. **MONGODB_URI**: URI de conexión a MongoDB
   - Para MongoDB local: `mongodb://localhost:27017/civgame`
   - Para MongoDB Atlas: `mongodb+srv://<username>:<password>@<cluster-address>/civgame`

2. **SECRET_KEY**: Clave secreta para JWT (ya incluye un valor por defecto)
   - Para generar una nueva: `openssl rand -hex 32` en terminal
   - O en Python: `import secrets; print(secrets.token_hex(32))`

3. **GROQ_API_KEY**: Clave API para las funciones de IA
   - Obtener en: [https://console.groq.com/keys](https://console.groq.com/keys)
   - Si no se proporciona, las funciones de IA no estarán disponibles

#### Variables Opcionales (si se usa Keycloak):

- **KEYCLOAK_BASE_URL**: URL base de tu servidor Keycloak
- **KEYCLOAK_REALM**: Nombre del realm en Keycloak
- **KEYCLOAK_CLIENT_ID**: ID del cliente en Keycloak
- **KEYCLOAK_CLIENT_SECRET**: Secreto del cliente en Keycloak
- **KEYCLOAK_ADMIN_CLIENT_ID**: ID del cliente admin en Keycloak
- **KEYCLOAK_ADMIN_CLIENT_SECRET**: Secreto del cliente admin en Keycloak

> Nota: El archivo `.env.template` contiene todas estas variables con comentarios explicativos.

### Build & Run (Docker Compose)
```pwsh
# Windows PowerShell
./compose_up.ps1
```
Or manually:
```pwsh
docker compose up --build
```
- Frontend: http://localhost:8080
- Backend: http://localhost:8000

### Local Development
#### Frontend
```pwsh
cd frontend
pnpm install
pnpm start
```
#### Backend
```pwsh
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

## Development
- Frontend: Angular CLI (`frontend/README.md` for details)
- Backend: FastAPI, see `backend/main.py` and `backend/app/`
- MongoDB: Used for users, games, scenarios
- AI: See `backend/app/services/ai_agent.py`

## API & Data Structures
- REST endpoints for auth, games, scenarios, cheat codes
- Game state and save format: see [civilizatu-euskaraz.md.txt](frontend/civilizatu-euskaraz.md.txt) section 12
- Example endpoints:
  - `POST /api/auth/register` / `login` / `profile`
  - `GET/POST /api/games`, `/api/games/{id}`
  - `POST /api/games/{id}/action`, `/endTurn`, `/cheat`

## AI Integration
- Backend sends game state to GroQ LLM for AI turns
- Handles model switching on rate limits
- Returns AI actions as JSON for frontend animation
- See [civilizatu-euskaraz.md.txt](frontend/civilizatu-euskaraz.md.txt) section 11/12/13

## License
This project is licensed under the GNU General Public License v3. See [LICENSE](LICENSE) for details.
