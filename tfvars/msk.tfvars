mskPrivateSubnetIds = ["subnet-0a1b2c3d4e5f6g7h", "subnet-0a1b2c3d4e5f6g7i"]

vpc_id = "vpc-0a1b2c3d4e5f6g7j"

region = "us-east-1"

aws_provider = "default"

common_tags = {
  "Environment": "dev1",
}

product_family = "CSD"

msk = {
  siyrce_security_group_id = "sg-0a1b2c3d4e5f6g7k"
  number_of_kafka_broker_nodes = 3
  instance_type = "kafka.m5.large"
  disk_size_per_broker = 100
  msk_cluster_name = "dev1-msk-cluster1"
}

csd_tags = {
  tags = {
    product_family = "CSD"
    product = "PI"
    environment = "dev1"
    customer = "customer1"
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
