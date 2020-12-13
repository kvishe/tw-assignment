variable "image_id"{
  description = "The image_id for EC2 instances"
}

variable "cluster_name"{
  description = "The name to use for the all cluster resources"
}

variable "instance_type"{
  description = "The type of EC2 instances to run"
}

variable "aws_key"{
  description = "The aws_key to access EC2 instances in the ASG"
}

variable "min_size"{
  description = "The minimum number of EC2 instances in the ASG"
}

variable "max_size"{
  description = "The maximum number of EC2 instances in the ASG"
}
