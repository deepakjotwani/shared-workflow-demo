# AWS SQS

- This terraform module will create a aws SQS.

Terraform versions
------------------

Terraform 0.14.8

## What is Amazon Simple Queue Service?

Amazon Simple Queue Service (Amazon SQS) offers a secure, durable, and available hosted queue that lets you integrate and decouple distributed software systems and components. Amazon SQS offers common constructs such as dead-letter queues and cost allocation tags. It provides a generic web services API that you can access using any programming language that the AWS SDK supports.

Amazon SQS supports both standard and FIFO queues.

Standard Queue

- It has a benefit of supporting an ample amount of transactions per second per API action.
- As the message is delivered on at a time but at the same time, it delivers more than one copy of a message.
- It may happen that the message delivered is in the different order from the source in which they were sent.
<p align="center">
<img src="https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/images/sqs-what-is-sqs-standard-queue-diagram.png" width="400" class="center">
</p>            

FIFO Queue

- It has a high throughput which can send 300 messages per second which include 300 send, receive, and delete operation per second.
- The message is not duplicated it is stored with the customer until and unless customer deletes it.
- The messages are treated in first in first out order as the message sent and received is strictly preserved.
<p align="center">
  <img src="https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/images/sqs-what-is-sqs-fifo-queue-diagram.png" width="400" class="center">
</p>

## What is dead-letter queues? 

Amazon SQS supports dead-letter queues, which other queues (source queues) can target for messages that can't be processed (consumed) successfully. Dead-letter queues are useful for debugging your application or messaging system because they let you isolate problematic messages to determine why their processing doesn't succeed.

## Important Notes

The dead-letter queue of a FIFO queue must also be a FIFO queue. Similarly, the dead-letter queue of a standard queue must also be a standard queue.

## Usage

```hcl
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

## Local tags are used to define common tags. 
locals {
  tags = { "ENVIRONMENT" : "test", "CLIENT" : "DEVOPS", "PROJECT" : "Demo", "ORGANISATION" : "opstree" }
}

## Example for FIFO Queue
module "sqs" {
  source            = "./modules/sqs"
  name              = ["sample", "demo"]
  tags              = merge({ PROVISIONER = "Terraform"},local.tags)
  fifo_queue        = true
}
## Example for Standard Queue
module "sqs" {
  source            = "./modules/sqs"
  name              = ["sample", "demo"]
  tags              = merge({ PROVISIONER = "Terraform"},local.tags)
}
## Example for enabling dead letter Queue in FIFO
module "sqs" {
  source            = "./modules/sqs"
  name              = ["sample", "demo"]
  tags              = merge({ PROVISIONER = "Terraform"},local.tags)
  fifo_queue        = true
  dead_letter_queue = true
}
## Example for enabling dead letter Queue in Standard
module "sqs" {
  source            = "./modules/sqs"
  name              = ["sample", "demo"]
  tags              = merge({ PROVISIONER = "Terraform"},local.tags)
  dead_letter_queue = true
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | Define the target region value | string | "us-east-1" | yes |
| profile | select aws cli profile name | string | "default" | yes |
| name | 	List of the SQS queue names. If you provide multiple names, each queue will be setup with the same configuration | list |""| yes |
| tags | Additional tags | string | "" | no |
| message_retention_seconds | The number of seconds Amazon SQS retains a message. | number | 345600 | no |
| max_message_size | The limit of how many bytes a message can contain before Amazon SQS rejects it. | number | 262144 | no |
| delay_seconds | The time in seconds that the delivery of all messages in the queue will be delayed. | number | 0 | no |
| receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. | string | 20 | no |
| fifo_queue | Boolean designating a FIFO queue. | string | "false" | no |
| content_based_deduplication | Enables content-based deduplication for FIFO queues. | bool | false | no |
| kms_master_key_id | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. | string | null | no |
| kms_data_key_reuse_period_seconds | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. | number | 300 | no |
| visibility_timeout_seconds | The visibility timeout for the queue. | number | 30 | no |
| dead_letter_queue | Enable dead letter queue | bool | false | no |
| max_receive_count | Maximum receive count | number | 5 | no |


## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the AWS SQS |
| id | The URL for the created Amazon SQS queue. |
| dlq_arn | The ARN of the AWS dead letter SQS |
| dlq_id | The URL for the created Amazon dead letter SQS queue. |
