aws_provider = "default" # (e.g., "default")
region       = "us-east-1"   # (e.g., "us-east-1")
vpc_id = "vpc-092c03af042c4e5b9" # ["vpc-0xxxxxxxxxxxxxx"]

#Please Make sure, mskPrivateSubnetIds = number_of_kafka_broker_nodes
mskPrivateSubnetIds =  ["subnet-0956c124b27675154", "subnet-07ce1229ad12b5cbd", "subnet-076dff0348cc6ca95"] # ["subnet-02xxxxxxxx6", "subnet-0bxxxxxxxxad", "subnet-0bxxxxxxxxad"]

# This variable is used to allow access to the msk from the specified CIDR blocks. 
# If you want to allow access from specific IP addresses fill it in or set this variable to an empty list.
external_cidrs = ["10.39.250.0/24", "10.45.10.0/24", "10.50.250.0/24", "10.52.250.0/24", "10.53.250.0/24", "10.100.8.0/23", "10.152.10.0/24", "10.153.10.0/24"]

#While upgrading, msk_cluster_name
#Please Make sure, mskPrivateSubnetIds = number_of_kafka_broker_nodes
#While upgrading CSD MSK, msk_cluster_name is the existing MSK cluster name without "cn-" prefix
#e.g. msk_cluster_name = "cn-msk-csf-sample4-csd" , Use msk_cluster_name = "msk-csf-sample4-csd"

msk = {
   config = {
        msk_cluster_name = "vmanep-use1-dev3-csf-msk" # (e.g., "msk-csf-sample4-csd")
        number_of_kafka_broker_nodes = "3" # (e.g., 3,2)
        instance_type = "kafka.t3.small" # (e.g., "kafka.m5.large")
        disk_size_per_broker = "10" # (e.g., 100)
        source_security_group_id = "sg-0b2bbd5bb231e02c1" # (e.g., "sg-0xxxxxxxxxxxxxx")   
    }
}
#When Upgrading MSK,source_security_group_id is the MSK SG's source group ID
#When creatin MSK,source_security_group_id is the environment's Bastion SG.

#product_family is either "csd" or "prov"
product_family = "CSD" # (e.g., The product_family must be one of: csd, prov)

#If the product_family is csd, these tags are mandotary
csd_tags = {
    tags = {
    product_family   = "CSD" # (e.g., The product_family must be one of: CSD, PROV)
    product          = "CSF"   # (e.g., The product must be one of: PI, CPQ, CS, OM, Catalog, INF, PROV, TL)
    environment      = "DEV"    # (e.g., The environment must be one of: PERF, DEV, PROV )
    customer         = "VM"  # (e.g., HSN, VM, Telefonica etc)
    }
}

#If the product_family is prov, these tags are mandotary
prov_tags = {
    tags = {
    GroupName        = "REPLACE WITH THE GROUP NAME" # (e.g., "csf-es-app")
    Name             = "REPLACE WITH THE NAME" # (e.g., "csf-es-app")
    TF_templates_version  = "REPLACE WITH THE TERRAFORM TEMPLATES VERSION" # (e.g., "2.0")
    }
}

#WHILE UPGRADING , PLEASE MAKE SURE TO KEEP THE BELOW CONFIGURATIONS AS IT IS
#This configurations are mainly required for prov product_family
msk_server_config = {
    msk_properties = {
        delete_topic_enable          = "false"
        auto_create_topics_enable    = "false"
        default_replication_factor   = "3"
        min_insync_replicas          = "2"
        num_io_threads               = "8"
        num_network_threads          = "5"
        num_partitions               = "1"
        num_replica_fetchers         = "2"
        replica_lag_time_max_ms      = "30000"
        socket_receive_buffer_bytes  = "102400"
        socket_request_max_bytes     = "104857600"
        socket_send_buffer_bytes     = "102400"
        unclean_leader_election_enable = "true"
        zookeeper_session_timeout_ms = "18000"
  }
}
