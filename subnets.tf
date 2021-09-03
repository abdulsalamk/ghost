
resource "google_compute_network" "drone-shuttles" {
  name                    = "drone-network"
  auto_create_subnetworks = false
}

# [START vpc_secondary_range_create]
resource "google_compute_subnetwork" "dev-subnet" {
  project       = var.project_name
  name          = "dev-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = var.network_name
  secondary_ip_range {
    range_name    = "dev-manage-subnet"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_subnetwork" "test-subnet" {
  project       = var.project_name
  name          = "test-subnet"
  ip_cidr_range = "10.20.0.0/16"
  region        = var.region
  network       = var.network_name
  secondary_ip_range {
    range_name    = "test-manage-subnet"
    ip_cidr_range = "192.168.20.0/24"
  }
}
resource "google_compute_subnetwork" "prod-subnet" {
  project       = var.project_name
  name          = "prod-subnet"
  ip_cidr_range = "10.30.0.0/16"
  region        = var.region
  network       = var.network_name
  secondary_ip_range {
    range_name    = "prod-manage-subnet"
    ip_cidr_range = "192.168.30.0/24"
  }
}

