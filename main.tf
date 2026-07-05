terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# 1. Модуль Мережі (VPC)
module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
}

# 2. Модуль Репозиторію для Docker-образів (ECR)
module "ecr" {
  source          = "./modules/ecr"
  environment     = var.environment
  repository_name = "django-app"
}

# 3. Модуль Кластера Kubernetes (EKS)
module "eks" {
  source      = "./modules/eks"
  environment = var.environment
  subnet_ids  = module.vpc.private_subnets
}

# 4. Модуль Бази Даних (RDS / Aurora)
module "rds" {
  source      = "./modules/rds"
  environment = var.environment
  name        = "django-db"

  use_aurora  = false # Змініть на true, якщо потрібна Aurora

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  db_name  = "django_db"
  username = "postgres"
  password = "SecurePassword2026!"
}