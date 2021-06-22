# GKE
## GENERAL
variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "gke_cluster_name" {
  description = "The default cluster name"
  type        = string
  default     = "cluster-gke"
}

variable "gke_release_channel" {
  description = "The release channel of this cluster. Accepted values are: UNSPECIFIED, RAPID, REGULAR and STABLE"
  type        = string
  default     = "STABLE"

  validation {
    condition = (
      var.gke_release_channel == "UNSPECIFIED" ||
      var.gke_release_channel == "REGULAR" ||
      var.gke_release_channel == "RAPID" ||
      var.gke_release_channel == "STABLE"
    )
    error_message = "Accepted values are UNSPECIFIED, RAPID, REGULAR and STABLE."
  }
}

variable "gke_version" {
  description = "Kubernetes version to use for the GKE cluster"
  type        = string
  default     = "latest"
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
  default     = "europe-west1"
}

variable "zones" {
  description = "The zones to host the cluster in"
  type        = list(string)
  default = [
    "europe-west1-b",
    "europe-west1-c",
    "europe-west1-d"
  ]
}

## WORKERS
variable "gke_node_pool_name" {
  description = "A suffix to append to the default node pool name"
  type        = string
  default     = "cluster-gke"
}

variable "gke_node_pool_machine_type" {
  description = "The instance type of node pool"
  type        = string
  default     = "e2-medium"
}

variable "gke_node_pool_min_count" {
  description = "The minimum nodes of node pool"
  type        = number
  default     = 1
}

variable "gke_node_pool_max_count" {
  description = "The maximun nodes of node pool"
  type        = number
  default     = 1
}

variable "gke_node_pool_volume_size" {
  description = "The size disk of node pool"
  type        = number
  default     = 100
}

variable "gke_node_pool_volume_type" {
  description = "The type of disk of node pool"
  type        = string
  default     = "pd-ssd"
}

# NETWORK
variable "vpc" {
  description = "The VPC network to host the cluster in"
  type        = string
}

variable "subnet" {
  description = "The subnetwork to host the cluster in"
  type        = string
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  type        = string
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  type        = string
}