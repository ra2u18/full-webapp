# ---------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------

# ---------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------
variable "author" {
  type        = string
  description = "Created by"
  default     = "rick@development.com"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
  default     = "management"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnets_count" {
  type        = number
  description = "Number of public subnets"
  default     = 2
}

variable "private_subnets_count" {
  type        = number
  description = "Number of private subnets"
  default     = 2
}

variable "ssl_arn" {
  type        = string
  description = "ARN of ssl"
}

variable "hosted_zone_id" {
  type        = string
  description = "Id of hosted zone"
}
