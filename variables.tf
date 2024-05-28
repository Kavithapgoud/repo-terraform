variable "region" {
    type = string
    default = "ap-south-1"
  
}
variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
  
}
variable "public_subnet_cidr" {
    type = string
    default = "10.0.120.0/24"
  
}

variable "private_subnet_cidr" {
    type = string
    default = "10.0.130.0/24"
  
}

variable "public_subnet_az" {
    type = string
    default = "ap-south-1a"
  
}

variable "private_subnet_az" {
    type = string
    default = "ap-south-1b"
  
}
variable "cidr_block_rt"{
  type = string
  default = "0.0.0.0/0"
}

