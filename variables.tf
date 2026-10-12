variable "security_group_name" {
  type        = string
  description = "The name of the RDS database security group"
  default     = "marina-rds-sg"
}

variable "allowed_security_group_ids" {
  type        = list(string)
  description = "List of EC2 Security Group IDs allowed to connect to the database"
}

variable "db_allocated_storage" {
  type        = number
  description = "The allocated storage size in GB"
  default     = 20
}

variable "db_max_allocated_storage" {
  type        = number
  description = "The maximum storage limit for autoscaling in GB"
  default     = 100
}

variable "db_engine_version" {
  type        = string
  description = "The MariaDB engine version"
  default     = "10.11"
}

variable "db_instance_class" {
  type        = string
  description = "The compute instance type class for the database"
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
  description = "The name of the initial database to create inside the instance"
}

variable "db_username" {
  type        = string
  description = "Master username for the database instance"
}

variable "db_password" {
  type        = string
  description = "Master password for the database instance"
  sensitive   = true
}

variable "db_tag_name" {
  type        = string
  description = "The Name tag value for the RDS resource"
  default     = "marina-rds-database"
}
