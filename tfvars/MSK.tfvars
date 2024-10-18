mskPrivateSubnetIds = ["subnet-0c3f2194402c04fa9", "subnet-0fae1d8535ce7b3f1", "subnet-08f4ca71cbb2f3fff"]

vpc_id = "vpc-018627f25e865fb9a"

region = "us-east-1"

aws_provider = "default"

common_tags = {
  "Environment": "fabriziotest",
}

product_family = "CSD"

msk = {
  source_security_group_id = "sg-0a1b2c3d4e5f6g7k"
  number_of_kafka_broker_nodes = 3
  instance_type = "kafka.t3.small"
  disk_size_per_broker = 10
  msk_cluster_name = "fabriziotest-msk-cluster1"
}

csd_tags = {
  tags = {
    product_family = "CSD"
    product = "PI"
    environment = "fabriziotest"
    customer = "fabriziotest"
  }
}

msk_server_config = {
  "msk_properties" = {
    delete_topic_enable          = "true"
    auto_create_topics_enable    = "true"
    default_replication_factor   = "3"
    min_insync_replicas          = "2"
    num_io_threads               = "8"
    num_network_threads          = "8"
    num_partitions               = "3"
    num_replica_fetchers         = "1"
    replica_lag_time_max_ms      = "10000"
    socket_receive_buffer_bytes  = "102400"
    socket_request_max_bytes     = "104857600"
    socket_send_buffer_bytes     = "102400"
    unclean_leader_election_enable = "false"
    zookeeper_session_timeout_ms = "6000"
  }
}
