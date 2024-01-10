terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("gcp-terraform-project-410623-ae5f8d61f718.json")

  project = "gcp-terraform-project-410623"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

///////////////////////////////////////////
//Nouvelle  ressource


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"] // la modification se faire a ce niveau

  boot_disk {
    initialize_params {
      //image = "debian-cloud/debian-11"  //-
      image = "cos-cloud/cos-stable"      //+
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}




