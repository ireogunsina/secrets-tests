aws_provider = "default" # (e.g., "default")
region       = "us-east-1"   # (e.g., "us-east-1")
vpc_id = "vpc-092c03af042c4e5b9" # ["vpc-0xxxxxxxxxxxxxx"]

##Make Sure, es_node_count = es_az_count = no. of subnet_ids
subnet_ids =  ["subnet-0956c124b27675154", "subnet-07ce1229ad12b5cbd"] # ["subnet-02xxxxxxxx6", "subnet-0bxxxxxxxxad", "subnet-0bxxxxxxxxad"]

# This variable is used to allow access to the elasticsearch/opensearch from the specified CIDR blocks. 
# If you want to allow access from specific IP addresses fill it in or set this variable to an empty list.
external_cidrs = ["10.39.250.0/24", "10.45.10.0/24", "10.50.250.0/24", "10.52.250.0/24", "10.53.250.0/24", "10.100.8.0/23", "10.152.10.0/24", "10.153.10.0/24"]

#product_family can be "csd" / "prov"
product_family = "CSD" # (e.g., The product_family must be one of: CSD, PROV)
base_product = "csd"

es = {
    config = {
    es_ebs_volume_size          = 200
    es_ebs_volume_type          = "gp3"
    es_throughput_per_node      = 250
    es_iops_per_node            = 3000
    es_instance_type            = "m7g.medium.elasticsearch" # (e.g., "m5.large.elasticsearch")
    es_node_count               = "2" # IT SHOULD BE SAME AS NO. OF SUBNETS YOU ARE USING (e.g., 3)
    es_zone_awareness_enabled   = true
    es_az_count                 = "2" # IT SHOULD BE SAME AS NO. OF SUBNETS YOU ARE USING  (e.g., 3)
    es_domain_name              = "vmanep-use1-dev3-csf-es" # (e.g., "csf-es-cpq")
    AWS_ACCOUNT_NO              = "895697895152" # (e.g., "123456789012")
    }
}

#If the product_family is csd, these tags are mandotary
csd_tags = {
    tags = {
    product_family   = "CSD" # (e.g., The product_family must be one of: CSD, PROV)
    product          = "CSF"   # (e.g., The product must be one of: PI, CPQ, CS, OM, Catalog, INF, PROV, TL)
    environment      = "DEV"    # (e.g., The environment must be one of: PRD, DEV, UAT, TST, PERF, AUDIT)
    customer         = "VM"  # (e.g., HSN, VM, Telefonica etc)
    }
}

#If the product_family is prov, below tags are mandotary
prov_tags = {
    tags = {
    GroupName        = "REPLACE WITH THE GROUP NAME" # (e.g., "csf-es-app")
    Name             = "REPLACE WITH THE NAME" # (e.g., "csf-es-app")
    TF_templates_version  = "REPLACE WITH THE TERRAFORM TEMPLATES VERSION" # (e.g., "2.0")
    }
}
