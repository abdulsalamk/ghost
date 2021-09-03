terraform {
  required_version = ">= 1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.82.0"
    }
  }
}
provider "google" {
  region  = var.region
  project =  var.project_name
  # Configuration options
}
