resource "aws_sqs_queue" "sqs_queue" {
  for_each                          = toset(var.name)
  name                              = "${each.value}${var.fifo_queue == "true" ? ".fifo" : ""}"
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  max_message_size                  = var.max_message_size
  delay_seconds                     = var.delay_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  fifo_queue                        = var.fifo_queue
  redrive_policy                    = var.dead_letter_queue == true ? "{\"deadLetterTargetArn\":\"${element(concat(values(aws_sqs_queue.sqs_queue_dlq)[*].arn), index(var.name, each.value))}\",\"maxReceiveCount\":${var.max_receive_count}}" : ""
  content_based_deduplication       = var.content_based_deduplication
  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  tags                              = var.tags
}
resource "aws_sqs_queue" "sqs_queue_dlq" {
  for_each                          = var.dead_letter_queue == true ? toset(var.name) : []
  name                              = "dlq_${each.value}${var.fifo_queue == "true" ? ".fifo" : ""}"
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  max_message_size                  = var.max_message_size
  delay_seconds                     = var.delay_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  fifo_queue                        = var.fifo_queue
  content_based_deduplication       = var.content_based_deduplication
  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  tags                              = var.tags
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  for_each  = var.create_sqs_queue_policy == true ? toset(var.name) : []
  queue_url = "${element(concat(values(aws_sqs_queue.sqs_queue)[*].id), index(var.name, each.value))}"
  policy    = var.aws_sqs_queue_policy
}

resource "aws_sqs_queue_policy" "sqs_queue_dlq_policy" {
  for_each  = var.create_sqs_queue_dlq_policy == true ? toset(var.name) : []
  queue_url = "${element(concat(values(aws_sqs_queue.sqs_queue_dlq)[*].id), index(var.name, each.value))}"
  policy    = var.aws_sqs_queue_dlq_policy
}

resource "aws_lambda_event_source_mapping" "example" {
  count            = var.create_lambda_mapping == true ? 1 : 0
  event_source_arn = "arn:aws:sqs:${var.region}:${var.account_id}:${local.queue_name[0]}"
  function_name    = var.lambda_function_arn
}