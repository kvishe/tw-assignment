variable "db_name"{
  description = "The name of database for the db resource"
}

variable "instance_name"{
  description = "The name to use for the db resources"
}

variable "instance_class"{
  description = "The type of db class instance to run"
}

variable "storage_size"{
  description = "The size of database storage"
}

variable "db_user"{
  description = "The admin user for the database"
}

variable "db_password"{
  description = "The admin password for the database"
}

variable "vpc_security_group_id"{
  description = "The vpc_security_group_id for the database"
}

