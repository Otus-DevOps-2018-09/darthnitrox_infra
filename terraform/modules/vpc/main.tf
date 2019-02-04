resource "google_compute_firewall" "firewall_ssh" {
    name    = "default-allow-ssh"
    network = "default"

    allow {
      protocol = "tcp"
      ports    = "${var.ssh_port}"
    }
    source_ranges = "${var.source_ranges}"
  }

  resource "google_compute_firewall" "firewall_http" {
    name = "default-allow-http"
    network = "default"

    allow {
      protocol = "tcp"
      ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]
  }