#Terraform testing cluster local

region             = "us-east-1"
aws_account_number = "895697895152"
dns_domain         = "vm.delivery.hansencx.com"
hosted_zone_id     = "Z0362731FLNB9XG7BLIO"
secret_file_name   = "wildcard_vm_delivery_hansencx_com.yaml"
aws_provider       = "default"
key_name           = "VirginMediaANEP"

# refer confluence page for more details on how to use networking_type
networking_type = "custom_networking" # custom_networking, default

#Refer variables.tf for more specific details
product        = "CSF" # e.g., The product must be one of: PI, CPQ, CS, OM, Catalog, INF, PROV, TL, CSF
schedule       = "24x7" #IST-BH, GMT-BH, EST-BH, PST-BH, 24x7
expiry_date    = "2030-12-31" # "2024-12-31"
environment    = "DEV" # e.g., The environment must be one of: "PRD", "DEV", "UAT", "TST", "PERF", "AUDIT"
product_family = "CSD" # e.g., The product_family must be one of: CSD, PROV
customer       = "VM" # "HSN"

#It is seperated with , for multiple owners and emails
cluster_owner_details = {
  created_by   = ["CSF Customer DevOps"] # ["Demo User"]
  owner_names  = ["CSF Customer DevOps"] # ["Demo User"]
  alert_emails = ["DL-ANEP-Devops@hansencx.com"] # ["demo.user@xyz.com"]
}

vpc_info = {
  vpc_id                           = "vpc-092c03af042c4e5b9" # "vpc-0xxxxxxxxxxxxxx"
  eks_secondary_private_subnet_ids = ["subnet-0564ae7def8f3893e", "subnet-0ace894e8491ae6b8", "subnet-0dfc3822440d99096"] # this where the pods are going to go
  eks_private_subnet_ids           = ["subnet-0956c124b27675154", "subnet-07ce1229ad12b5cbd", "subnet-076dff0348cc6ca95"] # this is where the EKS nodes + masters are going to go
  eks_public_subnet_ids            = [] # used only if we need to reach EKS from the outside
  eks_security_group_id            = "sg-0b2bbd5bb231e02c1" # this is going to be the EKS's secondary security group
}

##Use "MSK" or "test-confluent" based on the requirement
#kafka_conn_id = "MSK"
#
#kafka_conn_info = {
#  "MSK" = {
#    kafka_provider           = "REPLACE_THIS_WITH_KAFKA_PROVIDER" # "MSK"
#    msk_security_group       = "REPLACE_THIS_WITH_KAFKA_SECURITY_GROUP" # "sg-0xxxxxxxxxxxxxx"
#    bootstrap_brokers_tls    = "REPLACE_THIS_WITH_KAFKA_BROKER_URLS_WITH_COMMA_SEPERATED_VALUES" # "b-2.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:9094,b-3.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:9094,b-1.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:9094"
#    access_key               = "N/A"
#    secret_access_key        = "N/A"
#    zookeeper_connect_string = "null" # "z-2.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:2181,z-1.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:2181,z-3.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:2181" or "null"
#  }
#  "test-confluent" = {
#    kafka_provider           = "Confluent"
#    msk_security_group       = "N/A"
#    bootstrap_brokers_tls    = "REPLACE_THIS_WITH_BOOTSTRAP_BROKER_TLS"
#    access_key               = "REPLACE_THIS_WITH_ACCESS_KEY"
#    secret_access_key        = "REPLACE_THIS_WITH_SECRET_ACCESS_KEY"
#    zookeeper_connect_string = "null"
#  }
#}
#
#es_info = {
#  es_security_group  = ["REPLACE_THIS_WITH_COMMA_SEPARATED_ELASTIC_SEARCH_SECURITY_GROUP_ID"] # ["sg-0xxxxxxxxxxxxxx", "sg-0xxxxxxxxxxxxxx"] or ["sg-0xxxxxxxxxxxxxx"]
#  es_log_endpoint    = "REPLACE_THIS_WITH_ELASTIC_SEARCH_ENDPOINT" # "vpc-demo-es-logger1-demo.us-east-1.es.amazonaws.com"
#  es_app_endpoint    = "null" # "vpc-demo-es-testing-demo.us-east-1.es.amazonaws.com" or "null"
#}
#
##Provide if any Postgres security group is available, if not keep it as "null"
#pg_rds_security_group = "null"
#
#Provide if any Amazon memory db security group is available, if not keep it as "null"
amz_mem_db_security_group = "null"

# External CIDR blocks such as from Jenkins, bastion host or anywhere that are allowed to access the cluster, nodegroups, MSK, Elasticsearch/Opensearch, RDS for now.
# For example, you can set values in list of strings ["10.0.0.0/32", "10.0.0.1/32"] or set empty list []
# For this to work, either the infra resources should be within the VPC or else VPC peered with the other.

external_cidrs = ["10.39.250.0/24", "10.45.10.0/24", "10.50.250.0/24", "10.52.250.0/24", "10.53.250.0/24", "10.100.8.0/23", "10.152.10.0/24", "10.153.10.0/24"]

# map_roles can be customized to user requirement in below provided format. It is added to aws-auth configmap in the cluster.
map_roles = [
  {
    rolearn  = "arn:aws:iam::895697895152:role/CloudEngineerRole"
    username = "admin"
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::895697895152:role/SigmaDevOpsAdmin"
    username = "dev"
    groups = ["system:serviceaccounts:cpq",
      "system:serviceaccounts:catalog",
      "system:serviceaccounts:om",
      "system:serviceaccounts:cs",
      "system:serviceaccounts:pi",
      "system:serviceaccounts:informatics",
    "system:serviceaccounts:spark-operator"]
  }
]

# map_users can be customized to user requirement in below provided format. It is added to aws-auth configmap in the cluster.
map_users = [
  {
    userarn  = "arn:aws:iam::895697895152:user/Jenkins"
    username = "admin"
    groups   = ["system:masters"]
  },
  {
    userarn  = "arn:aws:iam::895697895152:user/automatecicd"
    username = "dev"
    groups = ["system:serviceaccounts:cpq",
      "system:serviceaccounts:catalog",
      "system:serviceaccounts:om",
      "system:serviceaccounts:cs",
      "system:serviceaccounts:pi",
      "system:serviceaccounts:informatics",
    "system:serviceaccounts:spark-operator"]
  }
]

# serviceaccounts can be customized to user requirement
serviceaccounts = [
  {
    serviceaccount = "catalog-sa"
    namespace      = "catalog"
  },
  {
    serviceaccount = "cs-sa"
    namespace      = "cs"
  },
  {
    serviceaccount = "om-sa"
    namespace      = "om"
  },
  {
    serviceaccount = "pi-sa"
    namespace      = "pi"
  },
  {
    serviceaccount = "cpq-sa"
    namespace      = "cpq"
  },
  {
    serviceaccount = "informatics-sa"
    namespace      = "informatics"
  },
  {
    serviceaccount = "spark-operator"
    namespace      = "spark-operator"
  },
  {
    serviceaccount = "dso-sa"
    namespace      = "tl"
  }, 
  {
    serviceaccount = "tl-sa"
    namespace      = "tl"
  }
]

# to create TLS secret in the cluster, customize based on serviceaccounts namespace parameter.
# allowed values are ["logging", "monitoring", "pi", "cpq", "catalog", "cs", "om", "informatics", "default"]
all_namespaces = ["logging", "monitoring", "pi", "cpq", "catalog", "cs", "om", "tl", "default"]


idp_connect_info = {
  auth_type     = "cognito"
  new_or_exists = "new"
  auth_scope    = "openid"
  exist_conn_info = {
  }
}

#Set to true if default user "bootstraper" to be created; otherwise, set it to false
cognito_default_user = false

#This is required only when product = "TL" and provide the resource server name and custome scopes
#cognito_resource_server = {
#  identifier   = "hansen-tl-resource-server" # Name of the resource server for TL
#  custom_scopes =  ["dso:Administrator",      # Multiple scopes for TL
#                    "dso:create_order",
#                    "dso:cancel_order",
#                    "dso:amend_order",                                                                                                         #                    "dso:manage_device",
#                    "dso:manage_service",
#                    "dso:emi_status",
#                    "dso:query_order",
#                    "dso:query_service",
#                    "dso:query_audit" ]
#}

# Custom Ingress Configuration

custom_ingress = {
  # App URLs. Each URL should map to the respective service. The format can vary, but it must contain the service keyword.
  # <dns_domain> value will be appended after whatever you provide as a value here Ex: test-grafana.prov.delivery.hansencx.com
  app_urls = {
    grafana    = "grafana-vmanep-use1-dev3-csf"    # Example: test-grafana or grafana-domain
    kibana     = "kibana-vmanep-use1-dev3-csf"     # Example: test-grafana or kibana-domain
    jaeger     = "jaeger-vmanep-use1-dev3-csf"     # Example: test-grafana or jaeger-domain
    argocd     = "argocd-vmanep-use1-dev3-csf"     # Example: test-grafana or argocd-domain
    prometheus = "prometheus-vmanep-use1-dev3-csf" # Example: test-grafana or prometheus-domain
  }

  # albRecs here used for creating cognito app callback urls.
  # Uncomment the product(s) and provide with the customized subdomain value completely except .<dns_domain> with comma(,) seperated for multiple
  # Allowed App callback urls gets created based on customized values Ex: https://catalog-ui-cluster.prov.delivery.hansencx.com/oauth2/idpresponse
  albRecs = {
    # Catalog = [] # <dns_domain> value will be appended after whatever you give here 
    # CPQ     = []
    PI      = [ "pi-ui-vmanep-use1-dev3-csf" ]
    # CS      = []
    OM      = ["grafana-vmanep-use1-dev3-csf", "jaeger-vmanep-use1-dev3-csf", "kibana-vmanep-use1-dev3-csf", "prometheus-vmanep-use1-dev3-csf", "om-ui-oct-vmanep-use1-dev3-csf", "om-ui-runtime-vmanep-use1-dev3-csf", "om-ui-designtime-vmanep-use1-dev3-csf"]
    # INF     = []
    # TL      = []  
    # PROV    = []
  }
  # nlbRecs here used for creating cognito api callback urls.
  # Uncomment the product(s) and provide with the customized record name completely except .<dns_domain> with comma(,) seperated for multiple
  # Allowed Api callback urls gets created based on customized values Ex: https://catalog-api-cluster.prov.delivery.hansencx.com/oauth2/idpresponse  
  nlbRecs = {
    # Catalog = [] # <dns_domain> value will be appended after whatever you give here
    # CPQ     = []
    PI      = ["pi-core-vmanep-use1-dev3-csf", "pi-history-vmanep-use1-dev3-csf"]
    CS      = ["cs-core-vmanep-use1-dev3-csf"]
    OM      = ["om-api-vmanep-use1-dev3-csf", "argocd-vmanep-use1-dev3-csf"]
    # INF     = []
    TL      = ["dso-api-vmanep-use1-dev3-csf", "dso-api-query-vmanep-use1-dev3-csf", "dso-audit-vmanep-use1-dev3-csf", "dso-core-vmanep-use1-dev3-csf", "dso-notification-vmanep-use1-dev3-csf", "dso-notification-stub-vmanep-use1-dev3-csf"]
    # PROV    = []
  }
  # Uncomment and replace with actual full signout URLs data with proper postfix value relevant to your environment only for PROV
  signout_urls = {
    # PROV = ["https://replace-with-workflow-signout-url", "https://replace-with-operations-signout-url"]
  }
}

monitoring_model = "eks-prometheus"
cluster_name     = "vmanep-use1-dev3-csf-eks"

#Set to true if the product is "INF"; otherwise, set it to false
deploy_spark               = false

#Set to true if the product is "Catalog"; otherwise, set it to false
deploy_windows_node = false

# to store helm charts in s3 bucket
helm_s3_bucket = "vm-om-helm-nv"

node_group_iops        = "3000"
node_group_throughput  = "125"
node_group_volume_size = "80"


eks_node_groups = {
  "firstNG" = {
    desired_node_size   = 3 #desired size and minimum size should be same value
    max_node_size       = 4
    min_node_size       = 3
    instance_type       = "t3a.2xlarge"
    version             = "1.30"
    ami_release_version = "1.30.4-20240924"
    k8s_labels = {
      app         = "monitoring"
      cluster     = "vmanep-use1-dev3-csf-eks"
      reservation = "worker"
    }
  }
}

# while considering single nodegroup to have both product and monitoring applications shared, 
# Below is an example of how to use k8s_labels for the same without taints.

# eks_node_groups= {
#         "firstNG" = {
#             desired_node_size   = REPLACE_THIS_WITH_DESIRED_NODE_SIZE #desired size and minimum size should be same value
#             max_node_size       = REPLACE_THIS_WITH_MAXIMUM_NODE_SIZE
#             min_node_size       = REPLACE_THIS_WITH_MANIMUM_NODE_SIZE
#             instance_type       = "REPLACE_THIS_WITH_INSTANCE_TYPE"
#             ami_release_version = "1.30.4-20240924"
#             k8s_labels = {
#                 cluster     = "REPLACE_THIS_WITH_CLUSTER_NAME"
#                 reservation = "worker"
# 		            app = "monitoring"
#              }
#         }
# }

#To deploy multiple nodes use 
  # "thirdNG" = {
  #   desired_node_size   = REPLACE_THIS_WITH_DESIRED_NODE_SIZE #desired size and minimum size should be same value
  #   max_node_size       = REPLACE_THIS_WITH_MAXIMUM_NODE_SIZE
  #   min_node_size       = REPLACE_THIS_WITH_MANIMUM_NODE_SIZE
  #   instance_type       = "REPLACE_THIS_WITH_INSTANCE_TYPE"
  #   version             = "REPLACE_THIS_WITH_EKS_VERSION_OF_NODE"
  #   ami_release_version = "1.30.4-20240924"
  #   k8s_labels = {
  #     cluster     = "REPLACE_THIS_WITH_CLUSTER_NAME"
  #     reservation = "worker"
  #   }
  # },
  # "fourthNG" = {
  #   desired_node_size   = REPLACE_THIS_WITH_DESIRED_NODE_SIZE #desired size and minimum size should be same value
  #   max_node_size       = REPLACE_THIS_WITH_MAXIMUM_NODE_SIZE
  #   min_node_size       = REPLACE_THIS_WITH_MANIMUM_NODE_SIZE
  #   instance_type       = "REPLACE_THIS_WITH_INSTANCE_TYPE"
  #   version             = "REPLACE_THIS_WITH_EKS_VERSION_OF_NODE"
  #   ami_release_version = "1.30.4-20240924"
  #   taints = [
  #     {
  #       key    = "reservation"
  #       value  = "monitoring"
  #       effect = "NO_SCHEDULE"
  #     }
  #   ]
  #   k8s_labels = {
  #     cluster     = "REPLACE_THIS_WITH_CLUSTER_NAME"
  #     reservation = "monitoring"
  #   }

############# FIXED VARIABLES FOR CN2.1. PLEASE DO NOT CHANGE ################

### for csd products always value is "one"
### for prov products it will be "dev, mid, xlarge". These sizes are related to profile they choose in 
## release train under project_folder/values/domain. 
## dev is non-clustered, mid is small, medium, large and xlarge is xlarge.
## So before filling, collect this info.
# refer confluence page for more details on how to use profile_size
profile_size = "one"

# BEGIN ANSIBLE MANAGED BLOCK
# BEGIN ANSIBLE MANAGED BLOCK

kafka_conn_info = {
  "MSK" = {
    kafka_provider        = "MSK"
    msk_security_group    = "sg-0f0d74b7afc2dd4b5"
    bootstrap_brokers_tls = "b-1.cnvmanepuse1dev3csfms.s8usig.c16.kafka.us-east-1.amazonaws.com:9094,b-2.cnvmanepuse1dev3csfms.s8usig.c16.kafka.us-east-1.amazonaws.com:9094,b-3.cnvmanepuse1dev3csfms.s8usig.c16.kafka.us-east-1.amazonaws.com:9094"
    access_key            = "N/A"
    secret_access_key     = "N/A"
    zookeeper_connect_string = "z-1.cnvmanepuse1dev3csfms.s8usig.c16.kafka.us-east-1.amazonaws.com:2181,z-2.cnvmanepuse1dev3csfms.s8usig.c16.kafka.us-east-1.amazonaws.com:2181,z-3.cnvmanepuse1dev3csfms.s8usig.c16.kafka.us-east-1.amazonaws.com:2181"
  }
}

es_info = {
  es_security_group  = ["sg-063bef96e483d3e72"]
  es_log_endpoint    = "vpc-vmanep-use1-dev3-csf-es-vtjcwcz3b3fctipoi43ne7mshm.us-east-1.es.amazonaws.com"
  es_app_endpoint    = "null"
}

pg_rds_security_group = "sg-01cbe7815b79ff630"
# END ANSIBLE MANAGED BLOCK
