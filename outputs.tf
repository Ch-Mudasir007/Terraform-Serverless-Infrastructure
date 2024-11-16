output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = module.lambda.lambda_arn
}

output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = module.api_gateway.api_gateway_url
}

output "rds_endpoint" {
  description = "The endpoint of the RDS MySQL instance"
  value       = module.rds.db_endpoint
}

output "event_rule_arn" {
  description = "The ARN of the CloudWatch EventBridge rule for Lambda"
  value       = module.event_scheduler.schedule_rule_arn
}