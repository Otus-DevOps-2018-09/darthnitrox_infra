resource "google_compute_instance" "app" {
    name = "reddit-app"
    machine_type = "g1-small"
    zone = "${var.zone}"
    tags = ["reddit-app"]

    boot_disk {
        initialize_params {
            image = "${var.app_disk_image}"
        }
    }
}
