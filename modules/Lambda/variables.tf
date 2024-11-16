variable "lambda_exec_role_arn" {
  description = "The ARN of the Lambda execution role"
}

variable "lambda_memory_size" {
  description = "The memory size for the Lambda function"
}

variable "lambda_timeout" {
  description = "The timeout for the Lambda function"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Lambda function"
}

variable "security_group_ids" {
  description = "List of security group IDs for the Lambda function"
}