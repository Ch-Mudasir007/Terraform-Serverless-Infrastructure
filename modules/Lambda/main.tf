resource "aws_lambda_function" "api_lambda" {
  function_name = "api-lambda-function"
  role          = var.lambda_exec_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  filename      = ""  # Blank for direct code entry

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = {
    Terraform = "TRUE"
    Project   = "API Processing"
  }
}