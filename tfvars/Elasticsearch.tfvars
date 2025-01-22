aws_provider = "default" # (e.g., "default")
region       = "us-east-1"   # (e.g., "us-east-1")
vpc_id = "vpc-092c03af042c4e5b9" # ["vpc-0xxxxxxxxxxxxxx"]

##Make Sure, es_node_count = es_az_count = no. of subnet_ids
subnet_ids =  ["subnet-0956c124b27675154", "subnet-07ce1229ad12b5cbd"] # ["subnet-02xxxxxxxx6", "subnet-0bxxxxxxxxad", "subnet-0bxxxxxxxxad"]

# This variable is used to allow access to the elasticsearch/opensearch from the specified CIDR blocks. 
# If you want to allow access from specific IP addresses fill it in or set this variable to an empty list.
external_cidrs = [ "10.143.93.32/32", "172.16.224.0/19" ]

#product_family can be "csd" / "prov"
product_family = "CSD" # (e.g., The product_family must be one of: CSD, PROV)

#for CSD, es_version = 7.10
#for prov, es_version = OpenSearch_1.2
#Make Sure, es_node_count = es_az_count = no. of subnet_ids
es_version = "OpeneSearch_2.13"

es = {
    config = {
    es_ebs_volume_size          = 200
    es_ebs_volume_type          = "gp3"
    es_throughput_per_node      = 250
    es_iops_per_node            = 3000
    es_instance_type            = "t4g.medium.search" # (e.g., "m5.large.elasticsearch")
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
