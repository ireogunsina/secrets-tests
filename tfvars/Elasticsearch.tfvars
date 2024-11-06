aws_provider = "default" 
region       = "us-east-1"
vpc_id = "vpc-092c03af042c4e5b9"

##Make Sure, es_node_count = es_az_count = no. of subnet_ids
subnet_ids =  ["subnet-0080a252cdef8fca8", "subnet-0fa1633be63514439"] 

#product_family can be "csd" / "prov"
product_family = "CSD" # (e.g., The product_family must be one of: CSD, PROV)

#for CSD, es_version = 7.10
#for prov, es_version = OpenSearch_1.2
#Make Sure, es_node_count = es_az_count = no. of subnet_ids
es = {
  config = {
    es_ebs_volume_size          = 50
    es_ebs_volume_type          = "gp3"
    es_throughput_per_node      = 250
    es_iops_per_node            = 3000
    es_instance_type            = "m7g.medium.elasticsearch"
    es_node_count               = 1
    es_zone_awareness_enabled   = true
    es_az_count                 = 2
    es_version                  = "7.10"
    es_domain_name              = "fabriziotest"
    AWS_ACCOUNT_NO              = "895697895152" 
  }
}

#If the product_family is csd, these tags are mandotary
csd_tags = {
  tags = {
    product_family   = "CSD" # (e.g., The product_family must be one of: CSD, PROV)
    product          = "PI"   # (e.g., The product must be one of: PI, CPQ, CS, OM, Catalog, INF, PROV, TL)
    environment      = "fabriziotest"    # (e.g., The environment must be one of: PRD, DEV, UAT, TST, PERF, AUDIT)
    customer         = "HSN"  # (e.g., HSN, VM, Telefonica etc)
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

