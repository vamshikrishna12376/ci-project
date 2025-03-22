# CI/DevOps Project

A comprehensive CI/CD and DevOps implementation project that demonstrates modern software delivery practices, infrastructure automation, and continuous integration/deployment pipelines.

## 📋 Overview

This project showcases a complete DevOps toolchain implementation including:

- Continuous Integration with automated testing and quality gates
- Containerization with Docker and security scanning
- Infrastructure as Code using Terraform with AWS integration
- CI/CD pipelines with Jenkins and GitHub Actions
- Blue/Green deployment strategies
- Comprehensive monitoring and logging
- Secrets management and security best practices
- API documentation with OpenAPI/Swagger

## 🏗️ Project Structure

```
ci-project/
│── 📁 src/                  # Source code
│   ├── 📁 main/             # Application logic
│   │   ├── app.py          # Main application entry point
│   │   ├── logger.py       # Logging configuration
│   ├── 📁 test/             # Unit & Integration tests
│       ├── test_app.py     # Tests for the application
│
│── 📁 scripts/              # Automation scripts
│   ├── build.sh            # Script to build the project
│   ├── test.sh             # Script to run tests
│   ├── deploy.sh           # Deployment script
│   ├── smoke-test.sh       # Smoke tests for deployments
│   ├── blue-green-deploy.sh # Blue-Green deployment script
│
│── 📁 docker/               # Docker configurations
│   ├── Dockerfile          # Docker image setup
│   ├── entrypoint.sh       # Startup script for the container
│
│── 📁 jenkins/              # Jenkins-specific configurations
│   ├── Jenkinsfile         # Pipeline as code
│   ├── post-build.sh       # Post-build actions
│
│── 📁 terraform/            # Infrastructure as Code (AWS Setup)
│   ├── main.tf             # Terraform main config
│   ├── variables.tf        # Variables for AWS resources
│   ├── monitoring.tf       # Monitoring resources
│   ├── secrets.tf          # Secrets management
│
│── 📁 config/               # Configuration files
│   ├── application.yml     # App configurations
│   ├── database.yml        # DB configurations
│
│── 📁 performance/          # Performance testing
│   ├── locustfile.py       # Locust performance tests
│
│── 📁 docs/                 # Documentation
│   ├── architecture.md     # Architecture documentation
│   ├── 📁 api/              # API documentation
│       ├── openapi.yaml    # OpenAPI/Swagger specification
│
│── 📁 reports/              # Reports from CI tests (generated)
│   ├── test-reports/       # Unit & integration test reports
│   ├── coverage/           # Code coverage reports
│
│── .github/                 # GitHub Actions
│   ├── 📁 workflows/        # CI/CD workflows
│       ├── ci.yml          # GitHub Actions CI Pipeline
│
│── requirements.txt        # Python dependencies
│── README.md               # Project documentation
```

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose
- Git
- Python 3.9+
- Optional: Jenkins (for CI/CD pipeline)
- Optional: Terraform (for infrastructure provisioning)
- Optional: AWS CLI (configured with appropriate credentials)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ci-project.git
   cd ci-project
   ```

2. Set up the project structure:
   ```bash
   chmod +x scripts/setup.sh
   ./scripts/setup.sh
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Build the application:
   ```bash
   ./scripts/build.sh
   ```

5. Run tests:
   ```bash
   ./scripts/test.sh
   ```

6. Run the application locally:
   ```bash
   python src/main/app.py
   ```

### Docker Setup

1. Build the Docker image:
   ```bash
   docker build -t ci-project-app -f docker/Dockerfile .
   ```

2. Run the container:
   ```bash
   docker run -p 8080:8080 ci-project-app
   ```

### CI/CD Pipeline

The project includes a GitHub Actions workflow in `.github/workflows/ci.yml` that:
- Builds the application
- Runs tests
- Performs static code analysis
- Builds and scans Docker images
- Deploys to staging and production environments

## 🔄 CI/CD Pipeline

This project implements a comprehensive CI/CD pipeline using:

### Jenkins Pipeline

The `Jenkinsfile` in the jenkins directory defines a complete pipeline that:
- Performs static code analysis with Pylint
- Builds the application
- Runs security scanning with Bandit
- Executes unit and integration tests
- Analyzes code quality with SonarQube
- Builds and scans Docker images with Trivy
- Runs performance tests with Locust
- Implements Blue/Green deployment strategy
- Includes manual approval for production deployments
- Sends notifications via email and Slack

### GitHub Actions

Alternatively, the `.github/workflows/ci.yml` file defines a GitHub Actions workflow that performs similar CI/CD tasks.

### Quality Gates

The pipeline includes several quality gates that must be passed before deployment:
- Unit test pass rate > 90%
- Code coverage > 80%
- No critical security vulnerabilities
- SonarQube quality gate passing
- Performance test response time < 500ms

## 🐳 Docker

The application is containerized using Docker:

```bash
# Build the Docker image
docker build -t ci-devops-app -f docker/Dockerfile .

# Run the container
docker run -p 8080:8080 ci-devops-app
```

## 🏗️ Infrastructure as Code

The `terraform` directory contains configurations to provision the required AWS infrastructure:

- EC2 instances or ECS clusters
- Load balancers and CloudFront distribution
- Security groups and IAM roles
- VPC, subnets, and networking components
- RDS database instances
- CloudWatch monitoring and alerting
- AWS Secrets Manager for credentials
- VPC Flow Logs for network monitoring

## 📊 Monitoring and Observability

### Logging

The application uses a centralized logging system:
- Structured JSON logging
- Log rotation and retention
- CloudWatch Logs integration
- Correlation IDs for request tracing

### Metrics and Monitoring

- CloudWatch dashboards for infrastructure monitoring
- Custom application metrics
- Automated alerting via SNS
- Health checks and status endpoints

### Reporting

- Test reports and code coverage in the `reports` directory
- Performance test results with Locust
- Security scan reports from Trivy and Bandit
- SonarQube quality reports

## 🔧 Configuration

- Application and database configurations in the `config` directory
- Environment-specific settings (dev, staging, prod)
- Secrets management with AWS Secrets Manager
- Feature flags for controlled rollouts

## 📚 Documentation

- API documentation with OpenAPI/Swagger in `docs/api/openapi.yaml`
- Architecture documentation in `docs/architecture.md`
- Runbooks for common operational tasks
- Deployment and rollback procedures

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Contact

Email- vamshiiikrishnaaa@gmail.com

Project Link: [https://github.com/yourusername/ci-devops-project](https://github.com/vamshikrishna12376/ci-devops-project)
