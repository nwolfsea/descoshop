
provider "aws" {
  region = "us-east-1" # Podemos colocar a região da nossa preferência
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-cluster-example"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.08.1"
  master_username         = "admin"
  master_password         = "pass123456"
  database_name           = "descoshop-rds"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  storage_encrypted       = true # Ativa a criptografia em repouso
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.aurora_cluster.engine
}

resource "aws_security_group" "rds_sg" {
  name        = "aurora_sg"
  description = "Security group for Aurora DB"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Ajuste para IPs específicos
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

# resource "aws_rds_cluster" "aurora_cluster" {
#   # Outras configurações do cluster
#   enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
# }

  
}



