variable "region" {
type = string
default = "eu-north-1"
}


variable "cluster_name" {
type = string
default = "demo-eks-cluster"
}


variable "vpc_cidr" {
type = string
default = "10.0.0.0/16"
}


variable "public_subnets" {
type = list(string)
default = ["10.0.0.0/20", "10.0.16.0/20"]
}


variable "private_subnets" {
type = list(string)
default = ["10.0.32.0/20", "10.0.48.0/20"]
}


variable "node_group_desired_capacity" {
type = number
default = 2
}


variable "node_instance_type" {
type = string
default = "t3.micro"
}