variable "instance_size" {
  description = "The EC2 instance size to provision"
  type        = string
  default     = "t2.micro"
}

variable "env_tag" {
  description = "The environment tag (e.g., Dev, Prod)"
  type        = string
  default     = "Dev"
}
