variable "aws_region" {
  default = "us-west-2"
}

variable "public_key_path" {
  description = "The path to the public ssh key"
  type        = string
}

variable "private_key" {
  type = string
}

variable "private_key_path" {
  description = "The path to the private ssh key"
  type        = string
}

variable "name" {
  description = "A unique name to give all the resources"
  type        = string
  default     = "airflow"
}

variable "tags" {
  description = "Tags to attach to all resources"
  type        = map(string)
  default     = {}
}

variable "eip_id" {
  description = "The elastic ip id to attach to active instance"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The key pair to import"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.medium"
}