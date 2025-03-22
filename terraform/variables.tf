variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ci-devops-project"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "ci-devops-key"
}

variable "docker_image" {
  description = "Docker image name"
  type        = string
  default     = "ci-devops-app"
}

variable "docker_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

# Database credentials variables (for Secrets Manager)
variable "db_username" {
  description = "Database username"
  type        = string
  default     = "app_user"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "change_me_in_production"
  sensitive   = true
}

variable "db_host" {
  description = "Database host"
  type        = string
  default     = "db.example.com"
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "app_database"
}

# API keys variables (for Secrets Manager)
variable "api_public_key" {
  description = "API public key"
  type        = string
  default     = "public_key_placeholder"
  sensitive   = true
}

variable "api_private_key" {
  description = "API private key"
  type        = string
  default     = "private_key_placeholder"
  sensitive   = true
}

# Monitoring variables
variable "alert_email" {
  description = "Email address to send CloudWatch alerts to"
  type        = string
  default     = "alerts@example.com"
}