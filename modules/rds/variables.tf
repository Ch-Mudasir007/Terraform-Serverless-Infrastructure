variable "db_name" {
  description = "The name of the MySQL database"
}

variable "db_username" {
  description = "The username for the RDS MySQL instance"
}

variable "db_password" {
  description = "The password for the RDS MySQL instance"
}

variable "db_instance_class" {
  description = "The instance class for the RDS MySQL"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
}