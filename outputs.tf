output "gke_cluster_name" {
  value = module.gke.name
}

output "gke_cluster_endpoint" {
  value = module.gke.endpoint
}

output "gke_cluster_authorized_networks" {
  value = module.gke.master_authorized_networks_config
}

output "gke_cluster_version" {
  value = module.gke.master_version
}

output "gke_zones" {
  value = module.gke.zones
}

output "gke_cluster_node_pools" {
  value = module.gke.node_pools_names
}

output "gke_cluster_node_pools_version" {
  value = module.gke.node_pools_versions
}
