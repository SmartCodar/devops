vpc_cidr       = "10.0.0.0/16"
subnet_cidr    = "10.0.1.0/24"
instance_type  = "t2.micro"
key_name       = "tf_key"
ami_id         = "ami-0aff18ec83b712f05"
asg_min_size   = 1
asg_max_size   = 3
cpu_threshold  = 70
