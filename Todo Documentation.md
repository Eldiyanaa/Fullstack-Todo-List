# Cloud Engineering Pathway Assessment - Documentation

## 1. Setup Instructions

### Prerequisites
Before running the application, ensure you have the following installed:

- Docker
- Docker Compose
- Git

### Cloning the Repository
```sh
git clone <repository-url>
cd <repo-folder>
```

### Building and Running the Containers
To build and start the containers, run:
```sh
docker-compose up --build -d
```
This will build and start the Frontend, Backend, and Database containers.

### Stopping the Containers
To stop the running containers, use:
```sh
docker-compose down
```

### Verifying the Setup
Check if all containers are running:
```sh
docker ps
```
Access the application at:

- **Frontend**: [http://localhost:80](http://localhost:80)
- **Backend**: [http://localhost:3000](http://localhost:3000)
- **Database**: `localhost:27017`

## 2. Dockerfiles and Docker Compose

### Dockerfiles
Each application component (Frontend, Backend, and Database) has its own Dockerfile:

- **Frontend Dockerfile**: Uses a multi-stage build with Node.js to install dependencies and serve the React app with Nginx.
- **Backend Dockerfile**: Uses Python/Node.js to install dependencies, run migrations, and start the backend service.
- **Database Dockerfile**: Uses an official MongoDB image, preconfiguring environment variables for database setup.

Each Dockerfile defines necessary dependencies, exposes required ports, and optimizes the build process.

### Docker Compose
The `docker-compose.yml` file orchestrates the setup of the three containers. It defines:

- **Services**: frontend, backend, and database
- **Networks**: Ensuring seamless communication between services (`todo-network`)
- **Volumes**: For persistent database storage
- **Environment Variables**: For database credentials and application configuration

To start all services, simply run:
```sh
docker-compose up --build -d
```

## 3. Network and Security Configurations

### Network Setup
- The containers communicate using a custom Docker network (`todo-network`).
- The backend depends on the database, and the frontend depends on the backend.

### Exposed Ports
| Component  | Port  |
|------------|------|
| Frontend   | 80   |
| Backend    | 3000 |
| Database   | 27017 |

### Security Considerations
- Environment variables are used to store database credentials.
- The database is not exposed to the public, only accessible within the network.
- Volumes are used to persist database data.

## 4. Troubleshooting Guide

### Common Issues and Fixes

#### 1. Containers not starting
**Solution**: Run
```sh
docker-compose logs
```
and check for errors.

#### 2. Cannot connect to the database
**Solution**: Ensure the correct database credentials are used in `docker-compose.yml`.

#### 3. Ports are already in use
**Solution**: Stop conflicting processes or change the ports in `docker-compose.yml`.
```sh
sudo lsof -i :3000  # Check process using port 3000
kill -9 <PID>       # Kill the process
```

#### 4. Application not accessible on localhost
**Solution**:
- Ensure containers are running: `docker ps`
- Restart containers: `docker-compose restart`

## 5. Container Testing

### To verify if all services are running correctly, a testing script is needed. This script will:
- Check if all containers are running.
- Test the backend API for a response.
- Verify the database connection.

### Creating the Container Testing Script
Create a script named `test_containers.sh`. The script should include commands that:

- Check the running containers using `docker ps`.
- Test the backend API by sending a request to the backend URL.
- Verify the database connection by accessing the database container and running a command to show the databases.

### Running the Testing Script
Give the script execute permissions:
```sh
chmod +x test_containers.sh
```
Run the script:
```sh
./test_containers.sh
```
This will verify that the backend is reachable, the database is accessible, and all containers are running correctly.
