# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch the default public subnets (by their specific IDs)
data "aws_subnet" "default_public_subnet_1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  availability_zone = "us-east-1a" # Adjust for your region
}

data "aws_subnet" "default_public_subnet_2" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  availability_zone = "us-east-1b" # Adjust for your region
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source              = "./modules/lambda"
  lambda_exec_role_arn = module.iam.lambda_exec_role_arn
  lambda_memory_size  = var.lambda_memory_size
  lambda_timeout      = var.lambda_timeout
  subnet_ids          = [data.aws_subnet.default_public_subnet_1.id, data.aws_subnet.default_public_subnet_2.id]
  security_group_ids  = [aws_security_group.lambda_sg.id]
}

module "rds" {
  source            = "./modules/rds"
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
  subnet_ids        = [data.aws_subnet.default_public_subnet_1.id, data.aws_subnet.default_public_subnet_2.id]
}

module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_arn = module.lambda.lambda_arn
}

module "event_scheduler" {
  source = "./modules/event_scheduler"
  lambda_arn = module.lambda.lambda_arn
  schedule_expression = var.schedule_expression
}

# Security Group for Lambda
resource "aws_security_group" "lambda_sg" {
  vpc_id = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda_sg"
    Terraform = "TRUE"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows public access to RDS, restrict this to specific IP for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
    Terraform = "TRUE"
  }
}