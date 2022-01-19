terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

#"/home/northernjay/downloads/terraform-study-338201-aa83a430cdfd.json"
provider "google" {
  credentials = file(var.credentials_file)

  # project = "terraform-study-338201"
  # region  = "us-central1"
  # zone    = "us-central1-c"
  project = var.project
  region = var.region
  zone = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
