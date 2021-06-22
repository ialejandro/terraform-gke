provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  token                  = data.google_client_config.current.access_token
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "< 4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.10"
    }
  }

  required_version = ">= 0.13, < 0.14"

  backend "gcs" {
    bucket = "CHANGE-ME"
    prefix = "gke"
  }
}