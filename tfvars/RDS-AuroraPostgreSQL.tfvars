# AWS Provider configuration
aws_provider = "default"  # AWS provider (e.g., aws)
region        = "us-east-1"   # AWS region to deploy resources (e.g., us-east-1)

# Common Configuration Tags
product        = "CSF"        # Tag for product (e.g., OM)
product_family = "CSD"      # Tag for product family (e.g., PROV)
environment    = "TST"         # Tag for environment (e.g., TST)
customer       = "VM"       # Tag for customer (e.g., VM)

# VPC and Network Configuration
vpc_id            = "vpc-092c03af042c4e5b9"            # VPC ID for your resources (e.g., vpc)
subnet_ids         = [ "subnet-0956c124b27675154", "subnet-07ce1229ad12b5cbd", "subnet-076dff0348cc6ca95" ]  # List of subnet IDs (e.g., ["subnet", "subnet"])
availability_zones = [ "us-east-1a", "us-east-1b", "us-east-1c" ]  # List of availability zones (e.g., ["us-east-1a", "us-east-1b"])

# This variable is used to allow access to the database from the specified CIDR blocks. 
# If you want to allow access from specific IP addresses fill it in or set this variable to an empty list.
external_cidrs = ["10.39.250.0/24", "10.45.10.0/24", "10.50.250.0/24", "10.52.250.0/24", "10.53.250.0/24", "10.100.8.0/23", "10.152.10.0/24", "10.153.10.0/24", "10.143.94.30/32"]

# RDS Configuration
create_parameter_group = true  # Boolean to create a parameter group (true means it will be created)
bastion_sg_id           = "sg-0b2bbd5bb231e02c1"  # Security group ID for the bastion (e.g., sg-041e847022f09826a)

rds_performance_insights_enabled = true  # Boolean to enable performance insights for RDS (true or false)
instance_type                   = "db.t4g.medium"  # Instance type for RDS (e.g., db.t4g.medium)

master_username = "dba"  # Master username for RDS (e.g., db_master)
master_password = "w0t1ndaW0rldisThispswd?"  # Master password for RDS (e.g., 8PC2^MZ=!^5wR69(")

engine_version = "14.13"  # RDS engine version (e.g., 12.16)
