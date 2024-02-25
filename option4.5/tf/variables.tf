variable "name" {
  type = string
  description = "Environment Name"
}

variable "region" {
  type = string
  description = "AWS Region"
}

variable "function_s3_bucket_name"{
  type = string
  description = "AWS S3 Bucket name for locating the bucket"
}

variable "function_deploy_trigger_key" {
  type = string
  description = "AWS Region"
  default = "hash"

  validation {
    condition     = contains(["hash","commit"], lower(var.function_deploy_trigger_key))
    error_message = "The function_deploy_trigger_key value must be either 'hash' or 'commit'"
  }
}

variable "force_lambda_code_deploy" {
  type = bool
  description = "If the lambda package in s3 has the same commit id tag as the terraform build branch, the lambda will not update automatically. Set to True if making changes to Lambda code from on the same commit for example during development"
  default =  false
}