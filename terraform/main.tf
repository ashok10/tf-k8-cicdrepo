# Create VPC

module "vpc" {
 source = "terraform-aws-modules/vpc/aws"
 version = "~> 4.0"

name = "eks-vpc"
cidr = var.vpc_cidr


azs = slice(data.aws_availability_zones.available.names, 0, 2)
public_subnets = var.public_subnets
private_subnets = var.private_subnets


enable_nat_gateway = true
}


# EKS cluster
module "eks" {
source = "terraform-aws-modules/eks/aws"
version = "~> 19.0"


cluster_name = var.cluster_name
cluster_version = "1.27"
subnets = module.vpc.private_subnets


vpc_id = module.vpc.vpc_id


node_groups = {
default = {
desired_capacity = var.node_group_desired_capacity
instance_types = [var.node_instance_type]
key_name = try(var.ssh_key_name, null)
}
}


manage_aws_auth = true
}


# Data sources to wire kubernetes/helm providers
data "aws_eks_cluster" "cluster" {
name = module.eks.cluster_id
}


data "aws_eks_cluster_auth" "cluster" {
name = module.eks.cluster_id
}

# Sample Helm release (NGINX ingress) via Terraform helm provider
resource "helm_release" "nginx_ingress" {
name = "ingress-nginx"
repository = "https://kubernetes.github.io/ingress-nginx"
chart = "ingress-nginx"
namespace = "ingress-nginx"
create_namespace = true


values = [file("${path.module}/helm-values/nginx-values.yaml")]
}


output "cluster_name" {
value = module.eks.cluster_id
}


output "region" {
value = var.region
}