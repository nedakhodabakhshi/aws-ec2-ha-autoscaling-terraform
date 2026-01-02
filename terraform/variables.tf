variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "cloudops-ha"
}

variable "instance_type" {
  description = "EC2 instance type for Auto Scaling Group"
  type        = string
  default     = "t3.micro"
}
