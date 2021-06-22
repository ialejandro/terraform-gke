data "google_compute_subnetwork" "subnet" {
  name    = var.subnet
  project = var.project_id
  region  = var.region
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.gke_cluster_name
  kubernetes_version         = var.gke_version
  release_channel            = var.gke_release_channel
  region                     = var.region
  zones                      = var.zones
  network                    = var.vpc
  subnetwork                 = var.subnet
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = false
  horizontal_pod_autoscaling = false
  network_policy             = true
  create_service_account     = false
  remove_default_node_pool   = true

  master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.subnet.ip_cidr_range
      display_name = "VPC"
    },
  ]

  node_pools = [
    {
      name         = "${var.gke_cluster_name}-${var.gke_node_pool_name}-node-pool"
      machine_type = var.gke_node_pool_machine_type
      min_count    = var.gke_node_pool_min_count
      max_count    = var.gke_node_pool_max_count
      disk_size_gb = var.gke_node_pool_volume_size
      disk_type    = var.gke_node_pool_volume_type
    },
  ]

  node_pools_metadata = {
    all = {}

    "${var.gke_node_pool_name}-node-pool" = {
      iac = "terraform"
    }
  }
}

module "gke_auth" {
  source       = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  depends_on   = [module.gke]
  project_id   = var.project_id
  location     = module.gke.location
  cluster_name = module.gke.name
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = pathexpand("~/.kube/kubeconfig-${var.gke_cluster_name}")
}