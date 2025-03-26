variable "project_id" {
  description = "terraform-454909"
}

variable "region" {
  description = "europe-west9"
}

variable "zone" {
  description = "europe-west9-a"
}
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}
provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file("terraform-454909-cba8983f3c8d.json")
}
