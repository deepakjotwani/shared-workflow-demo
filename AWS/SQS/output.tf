output "arn" {
  value       = { for std in aws_sqs_queue.sqs_queue : std.name => std.arn }
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "id" {
  value       = { for std in aws_sqs_queue.sqs_queue : std.name => std.id }
  description = "The URL for the created Amazon SQS queue."
}

output "dlq_arn" {
  value       = { for dlq in aws_sqs_queue.sqs_queue_dlq : dlq.name => dlq.arn }
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "dlq_id" {
  value       = { for dlq in aws_sqs_queue.sqs_queue_dlq : dlq.name => dlq.id }
  description = "The URL for the created Amazon SQS queue."
}
