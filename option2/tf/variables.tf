variable "name" {
  type        = string
  description = "Environment Name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "function_s3_bucket_name" {
  type        = string
  description = "AWS S3 Bucket name for locating the bucket"
}

variable "function_deploy_trigger_key" {
  type        = string
  description = "Trigger for deploying lambda code bundles, can be 'hash' or 'commit'"
  default     = "hash"

  validation {
    condition     = contains(["hash", "commit"], lower(var.function_deploy_trigger_key))
    error_message = "The function_deploy_trigger_key value must be either 'hash' or 'commit'"
  }
}
