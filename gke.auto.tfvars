# GKE
## GENERAL
project_id       = "CHANGE-ME"
gke_cluster_name = "cluster-gke"
gke_version      = "latest"

## WORKERS
gke_node_pool_name         = "default"
gke_node_pool_machine_type = "e2-medium"
gke_node_pool_min_count    = 1
gke_node_pool_max_count    = 1
gke_node_pool_volume_size  = 100

# NETWORK
vpc               = "my-vpc"
subnet            = "my-subnet"
ip_range_pods     = "pods"
ip_range_services = "services"
