resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"  # Free tier eligible instance class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  # Ensure public accessibility and assign to public subnets
  publicly_accessible  = true

  tags = {
    Terraform   = "TRUE"
    Environment = "Development"
    DB_Name     = var.db_name
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = var.subnet_ids

  tags = {
    Name      = "rds_subnet_group"
    Terraform = "TRUE"
  }
}