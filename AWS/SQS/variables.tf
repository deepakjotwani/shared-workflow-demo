variable "name" {
  description = "List of the SQS queue names. If you provide multiple names, each queue will be setup with the same configuration"
  type        = list(string)
}
variable "visibility_timeout_seconds" {
  description = "The timeout in seconds of visibility of the message"
  type        = number
  default     = 30
}

variable "delay_seconds" {
  description = "Delay in displaying message"
  type        = number
  default     = 0
}

variable "lambda_function_arn" {
  default = null
  type    = string
  description = "provide the lambda function arn to create sqs lambda trigger"
}

variable "create_lambda_mapping" {
  description = "create sqs lambda function trigger"
  type        = bool
  default     = false
}

variable "max_message_size" {
  description = "Max size of the message default to 256KB"
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "Seconds of retention of the message default to 4 days"
  type        = number
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
  type        = number
  default     = 20
}

variable "dead_letter_queue" {
  description = "The dead letter queue to use for undeliverable messages"
  default     = false
  type        = bool
}

variable "max_receive_count" {
  description = "Maximum receive count"
  default     = 5
  type        = number
}

variable "fifo_queue" {
  description = "Configure the queue(s) to be FIFO queue(s). This will append the required extension `.fifo` to the queue name(s)."
  default     = "false"
  type        = string
}
variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues."
  type        = bool
  default     = false
}
variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
  type        = string
  default     = ""
}
variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes)."
  type        = number
  default     = 300
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

#SQS Queue policy variables
variable "create_sqs_queue_policy" {
  description = "Policy for sqs queue"
  default     = false
  type        = bool
}

variable "create_sqs_queue_dlq_policy" {
  description = "Policy for sqs dead letter queue"
  default     = false
  type        = bool
}

variable "aws_sqs_queue_policy" {
  type        = any
  description = "policy for SQS Queue"
  default     = ""
}

variable "aws_sqs_queue_dlq_policy" {
  type        = any
  description = "policy for SQS Dead letter queue"
  default     = ""
}

variable "region" {
  type = string
  default = "us-west-2"
}

variable "account_id" {
  type = string
  default = ""
}