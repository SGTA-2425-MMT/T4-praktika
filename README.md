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

This project uses git submodules for the `frontend` and `backend` directories. To clone the repository and initialize all submodules, run:

```pwsh
git clone --recurse-submodules <repository-url>
```

If you have already cloned the repository without submodules, initialize them with:

```pwsh
git submodule update --init --recursive
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
Create a `.env` file in the root with:
```
MONGODB_URI=mongodb://localhost:27017/civgame
KEYCLOAK_BASE_URL=...
KEYCLOAK_REALM=...
KEYCLOAK_CLIENT_ID=...
KEYCLOAK_CLIENT_SECRET=...
KEYCLOAK_ADMIN_CLIENT_ID=...
KEYCLOAK_ADMIN_CLIENT_SECRET=...
GROQ_API_KEY=...
```

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
