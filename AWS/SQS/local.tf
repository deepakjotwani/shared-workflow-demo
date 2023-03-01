locals {
  queue_name = tolist([ for std in aws_sqs_queue.sqs_queue : std.name ])
}