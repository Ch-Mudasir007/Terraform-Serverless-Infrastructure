# Common variables for the infrastructure
variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "anurag"
}

variable "db_password" {
  default = "anurag@1234"
}

variable "db_instance_class" {
  default = "db.t3.micro" # Free tier eligible instance class
}

variable "lambda_memory_size" {
  default = 128
}

variable "lambda_timeout" {
  default = 10
}

variable "schedule_expression" {
  default = "rate(5 minutes)"
}