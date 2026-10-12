# 1. Retrieve the default VPC
data "aws_vpc" "default" {
  default = true
}

# 2. Creation of the Security Group for the RDS Database
resource "aws_security_group" "rds_sg" {
  name        = var.security_group_name
  description = "Inbound access for EC2 instances"
  vpc_id      = data.aws_vpc.default.id

  # Ingress rule: allows traffic on port 3306 from trusted security groups
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  # Standard outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

# 3. Creation of the RDS MariaDB Database Instance
resource "aws_db_instance" "marina_db" {
  allocated_storage      = var.db_allocated_storage
  max_allocated_storage  = var.db_max_allocated_storage
  engine                 = "mariadb"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = var.db_tag_name
  }
}

# 4. Database endpoint output for configuration files (e.g., wp-config.php)
output "rds_endpoint" {
  value       = aws_db_instance.marina_db.endpoint
  description = "The database endpoint to be used as DB_HOST"
}
