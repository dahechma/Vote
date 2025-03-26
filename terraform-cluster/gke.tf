resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke-cluster"
  location = var.region

  network    = google_compute_network.myvpc.name
  subnetwork = google_compute_subnetwork.mysubnet.name

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = 2

  node_config {
    machine_type = "e2-medium"

    disk_type    = "pd-standard" # SSD is "pd-ssd"
    disk_size_gb = 30            # Reduce from default 100 GB

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
