# MySQL CRUD Application - Production Deployment

A full-stack MySQL CRUD application with Node.js backend, React frontend, and MariaDB database, containerized for production deployment.

## Architecture

- **Database**: MariaDB 10.11
- **Backend**: Node.js (Express) API
- **Frontend**: React (Vite) served via NGINX
- **Container Registry**: Docker Hub (dujohnson7)

## Project Structure

```
devops/
├── .github/
│   └── workflows/
│       ├── backend.yml        # GitHub Actions workflow for backend
│       └── frontend.yml       # GitHub Actions workflow for frontend
├── backend/                   # Node.js API
│   ├── Dockerfile
│   ├── package.json
│   └── ...
├── frontend/                  # React app
│   ├── Dockerfile
│   ├── nginx.conf
│   └── ...
├── k8s/                       # Kubernetes manifests
│   ├── mariadb-dp.yaml
│   ├── nodejs-api-deployment.yaml
│   ├── nodejs-api-service.yaml
│   ├── react-app-config.yaml
│   ├── react-deployment.yaml
│   └── react-service.yaml
├── mariadb/                   # Database initialization
│   └── init.sql
├── docker-compose.yml         # Development Docker Compose
├── docker-compose.prod.yml    # Production Docker Compose
└── README.md
```

## Quick Start

### Prerequisites

- Docker and Docker Compose
- Node.js 18+ (for local development)
- kubectl (for Kubernetes deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/Dujohnson7/devops-final/.git
   cd devops
   ```

2. **Start the application**
   ```bash
   docker-compose up --build
   ```

3. **Access the application**
   - Frontend: http://localhost
   - Backend API: http://localhost:5000
   - Database: localhost:3306

### Production Deployment

#### Docker Compose (Production)

1. **Set up environment variables**
   ```bash
   cp env.prod.example .env
   # Edit .env with your production values
   ```

2. **Deploy with production images**
   ```bash
   docker-compose -f docker-compose.prod.yml up -d
   ```

#### Kubernetes Deployment

1. **Apply Kubernetes manifests**
   ```bash
   kubectl apply -f k8s/
   ```

2. **Check deployment status**
   ```bash
   kubectl get pods
   kubectl get services
   ```

3. **Get external IP**
   ```bash
   kubectl get service react-service
   ```

## GitHub Actions

The repository includes automated CI/CD workflows:

- **Backend Workflow** (`.github/workflows/backend.yml`): Builds and pushes backend images
- **Frontend Workflow** (`.github/workflows/frontend.yml`): Builds and pushes frontend images

### Required Secrets

Add these secrets to your GitHub repository:

- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`

## API Endpoints

- `GET /` - Get all users
- `POST /` - Create a new user
- `PUT /` - Update a user
- `DELETE /` - Delete a user
- `GET /health` - Health check

## Environment Variables

### Backend
- `DB_HOST`: Database host (default: mariadb)
- `DB_USER`: Database user
- `DB_PASSWORD`: Database password
- `DB_DATABASE`: Database name
- `DB_TABLENAME`: Table name
- `PORT`: Server port (default: 5000)

### Frontend
- `API_URL`: Backend API URL (default: /api)

## Database Schema

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Troubleshooting

### Common Issues

1. **Database connection issues**
   - Check if MariaDB is running and healthy
   - Verify environment variables
   - Check network connectivity

2. **Frontend not loading**
   - Verify NGINX configuration
   - Check if backend is accessible
   - Review container logs

3. **Kubernetes deployment issues**
   - Check pod status: `kubectl describe pod <pod-name>`
   - Review logs: `kubectl logs <pod-name>`
   - Verify secrets and configmaps

### Health Checks

- Backend: `GET /health`
- Frontend: `GET /`
- Database: `mysqladmin ping`

### Docker Deployment
 - Backend :  dujohnson7/crud-backend:latest
 - Frontend :  dujohnson7/crud-frontend:latest
 
