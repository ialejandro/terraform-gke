# Terraform GKE deploy

## Documentation

* [Kubernetes provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
* [Google provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
* [GKE module](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest)
* [GKE Release versions](https://cloud.google.com/kubernetes-engine/docs/release-notes)

## Requirements

* Terraform: `>= 0.13, < 0.14`
* Generate `service-account` in GCP
* The VPC must be exists
* The subnets must be exists and ip ranges (pods and services)

## First steps!

1. Create bucket GCS to save `.tfstate`
2. Modify `config.tf` with properly `bucket`
3. Download `service-account` and `export GOOGLE_APPLICATION_CREDENTIALS=<path-credendtial>`
4. Modify `gke.auto.tfvars` with your values
5. Install all dependencies and providers: `terraform init`
6. Deploy: `terraform apply`

## Files

* `config.tf`: providers, requirements and backend for Terraform
* `gke.auto.tfvars`: values for deployment
* `main.tf`: main file with GKE resource
* `outputs.tf`: output resources
* `variables.tf`: declare all variables with default values

## Default values

```bash
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
```

## Tests

* (Average) Complete deployment: ~10 minutes
