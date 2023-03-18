variable "cluster_name" {
  # module.eks.cluster_name
}

variable "certificate_authority" {
  # data.aws_eks_cluster.cluster.certificate_authority.0.data
}

variable "cluster_endpoint" {
  # module.eks.cluster_endpoint
}

variable "name" {}
