resource "google_compute_disk" "app_disk" {
  name = "${var.project_id}-disk"
  type = "pd-standard"
  zone = var.zone
  size = 10 # in GB
}
