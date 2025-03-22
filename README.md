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
ci-devops-project/
│── 📁 src/                  # Source code
│   ├── 📁 main/             # Application logic
│   ├── 📁 test/             # Unit & Integration tests
│
│── 📁 scripts/              # Automation scripts
│   ├── build.sh            # Script to build the project
│   ├── test.sh             # Script to run tests
│   ├── deploy.sh           # Deployment script
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
│
│── 📁 config/               # Configuration files
│   ├── application.yml     # App configurations
│   ├── database.yml        # DB configurations
│
│── 📁 reports/              # Reports from CI tests
│   ├── test-reports/       # Unit & integration test reports
│   ├── coverage/           # Code coverage reports
│
│── .github/                 # GitHub Actions
│   ├── workflows/          # CI/CD workflows
│   ├── ci.yml              # GitHub Actions CI Pipeline
```

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose
- Jenkins (for CI/CD pipeline)
- Terraform (for infrastructure provisioning)
- AWS CLI (configured with appropriate credentials)
- Git
- Python 3.9+
- SonarQube (for code quality analysis)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ci-devops-project.git
   cd ci-devops-project
   ```

2. Set up environment variables:
   ```bash
   # Create a .env file for local development
   cp config/env.example .env
   # Edit the .env file with your configuration
   ```

3. Build the application:
   ```bash
   ./scripts/build.sh
   ```

4. Run tests:
   ```bash
   ./scripts/test.sh
   ```

5. Run the application locally:
   ```bash
   python src/main/app.py
   ```

6. Deploy infrastructure (requires AWS credentials):
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

7. Run performance tests:
   ```bash
   pip install locust
   locust -f performance/locustfile.py --web-host=localhost
   ```

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

Your Name - your.email@example.com

Project Link: [https://github.com/yourusername/ci-devops-project](https://github.com/yourusername/ci-devops-project)