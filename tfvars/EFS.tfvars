# AWS Provider configuration
aws_provider = "default"  # AWS profile to use (e.g., aws)
region        = "us-east-1"   # AWS region to deploy resources (e.g., us-east-1)

# VPC information
vpc_info = {
  vpc_id                           = "vpc-092c03af042c4e5b9" # "vpc-0xxxxxxxxxxxxxx"
  eks_private_subnet_ids           = ["subnet-0956c124b27675154", "subnet-07ce1229ad12b5cbd", "subnet-076dff0348cc6ca95"]
  eks_public_subnet_ids    = []
  eks_security_group_id    = "sg-0b2bbd5bb231e02c1"  # Replace with your security group ID
}

# EFS configuration
efs_access_points = [
  {
    name = "vmanep-use1-dev3-csf-access_point"  # Name for the EFS access point
    posix_user = {
      gid            = 1000          # POSIX group ID (e.g., 1000)
      uid            = 1000          # POSIX user ID (e.g., 1000)
      secondary_gids = []  # List of secondary POSIX group IDs (e.g., [2000])
    }
    root_directory = {
      path = "/"  # Root directory path for the EFS access point
      creation_info = {
        owner_gid   = 1000    # Owner's POSIX group ID (e.g., 1000)
        owner_uid   = 1000    # Owner's POSIX user ID (e.g., 1000)
        permissions = "755"  # Permissions for the directory (e.g., 755)
      }
    }
  }
]

# Tags
product_family  = "CSD"   # Tag for product family (e.g., CSD)
product         = "CSF"     # Tag for product (e.g., OM)
environment     = "DEV"      # Tag for environment (e.g., DEV)
customer        = "VM"    # Tag for customer (e.g., VM)
schedule        = "24x7"          # Tag for schedule (e.g., IST-BH)
expiry_date     = "2040-12-31"       # Tag for expiry date (e.g., 2024-12-31)
cluster_owner_details = {
  owner_names   = [ "CSF Customer DevOps" ]   # List of owner names
  alert_emails  = ["DL-ANEP-Devops@hansencx.com"]  # List of alert emails
}
cluster_name    = "vmanep-use1-dev3-csf-eks"  # Name of the cluster (e.g., csf-cpq)

# EFS settings
performance_mode = "generalPurpose"  # Performance mode for EFS (e.g., generalPurpose or maxIO)
throughput_mode  = "bursting"   # Throughput mode for EFS (e.g., bursting or provisioned)
encrypted        = true   # Encryption setting for EFS (true or false)

# BEGIN ANSIBLE MANAGED BLOCK

node_security_group_id = "sg-00bb181ae03ef2e18"
# END ANSIBLE MANAGED BLOCK
