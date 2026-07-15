output "cluster_id" {
  value = aws_eks_cluster.gowtham.id
}

output "node_group_id" {
  value = aws_eks_node_group.gowtham.id
}

output "vpc_id" {
  value = aws_vpc.gowtham_vpc.id
}

output "subnet_id" {
  value = aws_subnet.gowtham_subnet[*].id
}