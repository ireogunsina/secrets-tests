#Terraform testing cluster local

region             = "us-east-1"
aws_account_number = "895697895152"
dns_domain         = "vm.delivery.hansencx.com"
hosted_zone_id     = "Z0362731FLNB9XG7BLIO"
secret_file_name   = "REPLACE_THIS_WITH_TLS_SECRET_FILE"
aws_provider       = "default"
key_name           = "VirginMediaANEP"

# refer confluence page for more details on how to use networking_type
networking_type = "default" # custom_networking, default

#Refer variables.tf for more specific details
product        = "PI" # e.g., The product must be one of: PI, CPQ, CS, OM, Catalog, INF, PROV, TL
schedule       = "24x7" #IST-BH, GMT-BH, EST-BH, PST-BH, 24x7
expiry_date    = "2025-12-31" # "2024-12-31"
environment    = "DEV" # e.g., The environment must be one of: "PRD", "DEV", "UAT", "TST", "PERF", "AUDIT"
product_family = "CSD" # e.g., The product_family must be one of: CSD, PROV
customer       = "HSN" # "HSN"

#It is seperated with , for multiple owners and emails
cluster_owner_details = {
  created_by   = ["Fabrizio Vecchi"] # ["Demo User"]
  owner_names  = ["Fabrizio Vecchi"] # ["Demo User"]
  alert_emails = ["fabrizio.vecchi@hansencx.com"] # ["demo.user@xyz.com"]
}

vpc_info = {
  vpc_id                           = "vpc-092c03af042c4e5b9" # "vpc-0xxxxxxxxxxxxxx"
  eks_private_subnet_ids           = ["subnet-0fa1633be63514439", "subnet-0080a252cdef8fca8", "subnet-0efdd29ff5da430c0"] # ["subnet-02xxxxxxxx6", "subnet-0bxxxxxxxxad"]
  eks_secondary_private_subnet_ids = [] # ["subnet-02xxxxxxxx6", "subnet-0bxxxxxxxxad"] or []
  eks_public_subnet_ids            = ["subnet-074212fe099cd8009", "subnet-0816dec766219112d"] # ["subnet-02xxxxxxxx6", "subnet-0bxxxxxxxxad"]
  eks_security_group_id            = "sg-0c967c6496981f534" # "sg-0xxxxxxxxxxxxxx"
}

#Use "MSK" or "test-confluent" based on the requirement
kafka_conn_id = "MSK"

kafka_conn_info = {
  "MSK" = {
    kafka_provider           = "REPLACE_THIS_WITH_KAFKA_PROVIDER" # "MSK"
    msk_security_group       = "REPLACE_THIS_WITH_KAFKA_SECURITY_GROUP" # "sg-0xxxxxxxxxxxxxx"
    bootstrap_brokers_tls    = "REPLACE_THIS_WITH_KAFKA_BROKER_URLS_WITH_COMMA_SEPERATED_VALUES" # "b-2.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:9094,b-3.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:9094,b-1.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:9094"
    access_key               = "N/A"
    secret_access_key        = "N/A"
    zookeeper_connect_string = "null" # "z-2.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:2181,z-1.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:2181,z-3.demo.vrzrg1.c20.kafka.us-east-1.amazonaws.com:2181" or "null"
  }
  "test-confluent" = {
    kafka_provider           = "Confluent"
    msk_security_group       = "N/A"
    bootstrap_brokers_tls    = "REPLACE_THIS_WITH_BOOTSTRAP_BROKER_TLS"
    access_key               = "REPLACE_THIS_WITH_ACCESS_KEY"
    secret_access_key        = "REPLACE_THIS_WITH_SECRET_ACCESS_KEY"
    zookeeper_connect_string = "null"
  }
}

es_info = {
  es_security_group  = ["REPLACE_THIS_WITH_COMMA_SEPARATED_ELASTIC_SEARCH_SECURITY_GROUP_ID"] # ["sg-0xxxxxxxxxxxxxx", "sg-0xxxxxxxxxxxxxx"] or ["sg-0xxxxxxxxxxxxxx"]
  es_private_subnets = ["REPLACE_THIS_WITH_COMMA_SEPARATED_PRIVATE_SUBNET_IDS_OF_ELASTIC_SEARCH"] # ["subnet-01xxxxxxxxcb", "subnet-02xxxxxxxx6"]
  es_log_endpoint    = "REPLACE_THIS_WITH_ELASTIC_SEARCH_ENDPOINT" # "vpc-demo-es-logger1-demo.us-east-1.es.amazonaws.com"
  es_app_endpoint    = "null" # "vpc-demo-es-testing-demo.us-east-1.es.amazonaws.com" or "null"
}

#Provide if any Postgres security group is available, if not keep it as "null"
pg_rds_security_group = "null"

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
    userarn  = "arn:aws:iam::895697895152:user/csdadmin"
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
#serviceaccounts = [
#  {
#    serviceaccount = "demo1-sa"
#    namespace      = "demo1"
#  },
#  {
#    serviceaccount = "demo2-sa"
#    namespace      = "demo2"
#  }
#]

# to create TLS secret in the cluster, customize based on serviceaccounts namespace parameter.
# allowed values are ["logging", "monitoring", "pi", "cpq", "catalog", "cs", "om", "informatics", "default"]
all_namespaces = ["logging", "monitoring", "pi", "cpq", "catalog", "cs", "om", "informatics", "tl", "default"]


idp_connect_info = {
  auth_type     = "cognito"
  new_or_exists = "new"
  auth_scope    = "openid"
  exist_conn_info = {
  }
}

#This is required only when product = "TL" and provide the resource server name and custome scopes
#cognito_resource_server = {
#  identifier   = "hansen-tl-resource-server" # Name of the resource server for TL
#  custom_scopes =  ["dso:Administrator",      # Multiple scopes for TL
#                    "dso:create_order",
#                    "dso:cancel_order",
#                    "dso:amend_order",
#                    "dso:manage_device",
#                    "dso:manage_service",
#                    "dso:emi_status",
#                    "dso:query_order",
#                    "dso:query_service",
#                    "dso:query_audit" ]
#}

monitoring_model = "eks-prometheus"
cluster_name     = "fabriziotest"

#To deploy spark make it true, else false
deploy_spark               = false

#to deploy windows node make it true, else false
deploy_windows_node = false

# to store helm charts in s3 bucket
helm_s3_bucket = "REPLACE_THIS_WITH_HELM_S3_BUCKET_NAME"

node_group_iops        = 3000
node_group_throughput  = 250
node_group_volume_size = 25

# while considering all nodegroups to have both product and monitoring applications shared, 
# you can add additional k8s_labels and taints to the node_groups. For example, reservation=worker in both node_groups along with reservation=monitoring.
# Also taints, for example shows below
  # taints = [
  #   {
  #     key    = "example-key1"
  #     value  = "example-value1"
  #     effect = "NO_SCHEDULE"
  #   },
  #   {
  #     key    = "example-key2"
  #     value  = "example-value2"
  #     effect = "NO_EXECUTE"
  #   },
  # ]

eks_node_groups = {
  "firstNG" = {
    desired_node_size   = 3 #desired size and minimum size should be same value
    max_node_size       = 5
    min_node_size       = 0
    instance_type       = "t3.medium"
    ami_release_version = "1.29.0-20240202"
    k8s_labels = {
      cluster     = "fabriziotest"
      reservation = "worker"
    }
  }
}

#To deploy multiple nodes use 
  # "thirdNG" = {
  #   desired_node_size   = REPLACE_THIS_WITH_DESIRED_NODE_SIZE #desired size and minimum size should be same value
  #   max_node_size       = REPLACE_THIS_WITH_MAXIMUM_NODE_SIZE
  #   min_node_size       = REPLACE_THIS_WITH_MANIMUM_NODE_SIZE
  #   instance_type       = "REPLACE_THIS_WITH_INSTANCE_TYPE"
  #   ami_release_version = "1.29.0-20240202"
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
  #   ami_release_version = "1.29.0-20240202"
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

############# FIXED VARIABLES FOR CN2.0. PLEASE DO NOT CHANGE ################
cluster_version = "1.29"

### for csd products always value is "one"
### for prov products it will be "dev, mid, xlarge". These sizes are related to profile they choose in 
## release train under project_folder/values/domain. 
## dev is non-clustered, mid is small, medium, large and xlarge is xlarge.
## So before filling, collect this info.
# refer confluence page for more details on how to use profile_size
profile_size = "one"

common_helm_chart_versions = {
  "grafana"                    = "7.0.20"
  "prometheus"                 = "14.6.0"
  "logstash"                   = "7.17.3"
  "fluentbit"                  = "0.47.1"
  "jaeger-operator"            = "2.46.0"
  "argocd"                     = "5.53.10"
  "cert-manager"               = "1.12.9"
  "spark-operator"             = "1.4.6"
  "cluster-autoscaler"         = "9.36.0"
  "keda"                       = "2.14.2"
  "karpenter"                  = "N/A"
  "aws-alb-ingress-controller" = "1.5.2"
  "ingress-nginx"              = "4.7.2"
  "metrics-server"             = "3.12.1"
  "karpenter-crd"              = "N/A"
  "confluent_schema_registry"  = "0.6.1"
  "opentelemetry-collector"    = "0.101.2"
}

common_docker_image_versions = {
  cluster_autoscaler = "v1.29.4"
  keda = {
    keda                    = "2.14.0"
    keda-metrics-apiserver  = "2.14.0"
    keda-admission-webhooks = "2.14.0"
  }
  prometheus = {
    prometheus                    = "v2.26.0"
    prometheus_configmap_reload   = "v0.5.0"
    alertmanager_configmap_reload = "v0.5.0"
    alertmanager                  = "v0.21.0"
    node_exporter                 = "v1.1.2"
    pushgateway                   = "v1.3.1"
    busybox                       = "N/A"
    kube_state_metrics            = "N/A"
    k8s_sidecar                   = "N/A"
  }
  grafana = {
    grafana     = "10.2.2"
    busybox     = "1.31.1"
    k8s_sidecar = "1.25.2"
  }
  cert_manager = {
    cert-manager-controller = "v1.12.9"
    cert-manager-cainjector = "v1.12.9"
    cert-manager-webhook    = "v1.12.9"
    cert-manager-ctl        = "v1.12.9"
  }
  jaeger = {
    jaeger-operator  = "1.46.0"
    jaeger-agent     = "1.46.0"
    jaeger-collector = "1.46.0"
    jaeger-query     = "1.46.0"
  }
  logstash                   = "8.14.1"
  fluentbit                  = "3.1.1"
  karpenter                  = "v0.31.5"
  aws_alb_ingress_controller = "v2.5.1"
  spark_operator             = "v1beta2-1.6.2-3.5.0"
  nginx_ingress = {
    controller     = "v1.8.2"
    defaultbackend = "N/A"
  }
  metrics-server = "v0.7.1"
  confluent_schema_registry = {
    cp_zookeeper        = "N/A"
    cp_enterprise_kafka = "N/A"
    cp_schema_registry  = "6.1.0"
    cp_kafka_rest       = "N/A"
  }
  opentelemetry-collector = "0.106.1"
}

