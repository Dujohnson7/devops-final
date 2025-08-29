# MySQL CRUD Application - Production Deployment

This is a full-stack CRUD application with MySQL database, Node.js backend API, and React frontend, containerized and ready for production deployment using Docker and Kubernetes.

## 🏗️ Architecture

- **Database**: MariaDB 10.11
- **Backend**: Node.js with Express.js
- **Frontend**: React with Vite
- **Reverse Proxy**: Nginx
- **Containerization**: Docker & Docker Compose
- **Orchestration**: Kubernetes
- **CI/CD**: GitHub Actions

## 📁 Project Structure

```
devops-final/
├── .github/workflows/          # GitHub Actions CI/CD
│   ├── backend.yml            # Backend image build & push
│   └── frontend.yml           # Frontend image build & push
├── backend/                   # Node.js API
│   ├── Dockerfile
│   ├── index.js
│   ├── package.json
│   ├── db/ConnectDB.js
│   └── routes/DBOperRoutes.js
├── frontend/                  # React app
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── src/
│   └── package.json
├── k8s/                       # Kubernetes manifests
│   ├── mariadb-dp.yaml
│   ├── nodejs-api-deployment.yaml
│   ├── nodejs-api-service.yaml
│   ├── react-app-config.yaml
│   ├── react-deployment.yaml
│   └── react-service.yaml
├── mariadb/                   # Database initialization
│   └── init.sql
├── docker-compose.yml         # Development compose
├── docker-compose.prod.yml    # Production compose (images only)
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Node.js 18+ (for local development)
- Git

### Local Development

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Dujohnson7/devops-final.git
   cd devops-final
   ```

2. **Set up environment variables**:
   ```bash
   cp env.example .env
   # Edit .env with your database credentials
   ```

3. **Run with Docker Compose**:
   ```bash
   docker-compose up --build
   ```

4. **Access the application**:
   - Frontend: http://localhost:80
   - Backend API: http://localhost:5000
   - Database: localhost:3306

### Manual Setup (Alternative)

1. **Backend setup**:
   ```bash
   cd backend
   npm install
   cp ../env.example .env
   npm start
   ```

2. **Frontend setup**:
   ```bash
   cd frontend
   npm install
   npm run dev
   ```

## 🐳 Docker Deployment

### Development
```bash
docker-compose up --build
```

### Production (using pre-built images)
```bash
# Set up production environment
cp env.prod.example .env.prod
# Edit .env.prod with your production values

# Deploy with production compose
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

## ☸️ Kubernetes Deployment

### Prerequisites
- Kubernetes cluster (local: minikube, cloud: GKE, EKS, AKS)
- kubectl configured

### Deploy to Kubernetes

1. **Deploy MariaDB**:
   ```bash
   kubectl apply -f k8s/mariadb-dp.yaml
   ```

2. **Deploy Backend**:
   ```bash
   kubectl apply -f k8s/nodejs-api-deployment.yaml
   kubectl apply -f k8s/nodejs-api-service.yaml
   ```

3. **Deploy Frontend**:
   ```bash
   kubectl apply -f k8s/react-app-config.yaml
   kubectl apply -f k8s/react-deployment.yaml
   kubectl apply -f k8s/react-service.yaml
   ```

4. **Check deployment status**:
   ```bash
   kubectl get pods
   kubectl get services
   ```

5. **Access the application**:
   ```bash
   # Get external IP (LoadBalancer)
   kubectl get service frontend-service
   ```

## 🔄 CI/CD with GitHub Actions

### Setup

1. **Add Docker Hub secrets to GitHub**:
   - Go to your repository → Settings → Secrets and variables → Actions
   - Add `DOCKER_USERNAME` and `DOCKER_PASSWORD`

2. **Push to trigger builds**:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

### Workflows

- **Backend**: Builds and pushes `dujohnson7/crud-backend:latest`
- **Frontend**: Builds and pushes `dujohnson7/crud-frontend:latest`
- **Triggers**: Push to main/develop branches, pull requests

## 🌐 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET    | `/`      | Get all users |
| POST   | `/`      | Create new user |
| PUT    | `/`      | Update user |
| DELETE | `/`      | Delete user |

### Example API Usage

```bash
# Get all users
curl http://localhost:5000/

# Create user
curl -X POST http://localhost:5000/ \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "email": "john@example.com"}'

# Update user
curl -X PUT http://localhost:5000/ \
  -H "Content-Type: application/json" \
  -d '{"id": 1, "name": "Jane Doe", "email": "jane@example.com"}'

# Delete user
curl -X DELETE http://localhost:5000/ \
  -H "Content-Type: application/json" \
  -d '{"id": 1}'
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_HOST` | Database host | `localhost` |
| `DB_USER` | Database user | `appuser` |
| `DB_PASSWORD` | Database password | `apppassword` |
| `DB_DATABASE` | Database name | `crud_app` |
| `DB_TABLENAME` | Table name | `users` |
| `PORT` | Backend port | `5000` |
| `VITE_API_URL` | Frontend API URL | `/api` |

### Docker Images

- **Backend**: `dujohnson7/crud-backend:latest`
- **Frontend**: `dujohnson7/crud-frontend:latest`
- **Database**: `mariadb:10.11`

## 🛠️ Development

### Adding New Features

1. Make changes to backend/frontend
2. Test locally with Docker Compose
3. Push to GitHub (triggers CI/CD)
4. Deploy to production

### Database Schema

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 📊 Monitoring & Health Checks

- **Docker**: Health checks configured for all services
- **Kubernetes**: Liveness and readiness probes
- **Backend**: HTTP health check on `/`
- **Frontend**: HTTP health check on `/`
- **Database**: MySQL ping check

## 🔒 Security

- Non-root containers
- Secrets management in Kubernetes
- Environment variable injection
- Network isolation with custom bridge
- Health checks for service dependencies

## 📝 Troubleshooting

### Common Issues

1. **Database connection failed**:
   - Check if MariaDB is running and healthy
   - Verify environment variables
   - Check network connectivity

2. **Frontend can't reach backend**:
   - Verify nginx proxy configuration
   - Check if backend service is running
   - Ensure correct API URL configuration

3. **Kubernetes deployment issues**:
   - Check pod logs: `kubectl logs <pod-name>`
   - Verify secrets and configmaps
   - Check service endpoints

### Logs

```bash
# Docker Compose
docker-compose logs -f [service-name]

# Kubernetes
kubectl logs -f deployment/[deployment-name]
```

## 📄 License

This project is licensed under the MIT License.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For support, email adiel8511@gmail.com or create an issue in the repository.
