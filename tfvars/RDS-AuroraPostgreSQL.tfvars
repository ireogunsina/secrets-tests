# AWS Provider configuration
aws_provider = "default"  # AWS provider (e.g., aws)
region        = "us-east-1"   # AWS region to deploy resources (e.g., us-east-1)

# Common Configuration Tags
product        = "PI"        # Tag for product (e.g., OM)
product_family = "CSD"      # Tag for product family (e.g., PROV)
environment    = "DEV"         # Tag for environment (e.g., DEV)
customer       = "VM"       # Tag for customer (e.g., VM)

# VPC and Network Configuration
vpc_id            = "vpc-092c03af042c4e5b9"            # VPC ID for your resources (e.g., vpc-)
subnet_ids         = [ "subnet-0080a252cdef8fca8", "subnet-0fa1633be63514439" ]  # List of subnet IDs (e.g., ["subnet", "subnet"])
availability_zones = [ "us-east-1a", "us-east-1c" ]  # List of availability zones (e.g., ["us-east-1a", "us-east-1b"])

# This variable is used to allow access to the database from the specified CIDR blocks. 
# If you want to allow access from specific IP addresses fill it in or set this variable to an empty list.
external_cidrs = [ "10.0.0.0/8" ]  # e.g., ["10.0.0.0/32" , "10.0.0.1/32"] or []

# RDS Configuration
create_parameter_group = false  # Boolean to create a parameter group (false means it will not be created)
bastion_sg_id           = "sg-08b439c941a9b9f44"  # Security group ID for the bastion (e.g., sg-041e847022f09826a)

rds_performance_insights_enabled = true  # Boolean to enable performance insights for RDS (true or false)
instance_type                   = "db.t4g.micro"  # Instance type for RDS (e.g., db.t4g.medium)

master_username = "fabriziotest_dba"  # Master username for RDS (e.g., db_master)
master_password = "w0tnopasswd?"  # Master password for RDS (e.g., 8PC2^MZ=!^5wR69(")

engine_version = "14.9"  # RDS engine version (e.g., 12.16)

