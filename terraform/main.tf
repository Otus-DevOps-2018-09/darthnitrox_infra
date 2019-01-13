provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}


resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_instance" "app" {
  name         = "reddit-app-1"
  machine_type = "g1-small"
  zone         = "${var.zone}"
    
  connection {
        type="ssh"
        user="appuser"
        agent=false
        private_key="${file("~/.ssh/appuser")}"
    }
    
    provisioner "file" {
        source="files/puma.service"
        destination="/tmp/puma.service"
    }

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file("${var.public_key_path}")}"
  }

  network_interface {
    network       = "default"
    access_config = {
     nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("${var.private_key_path}")}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  tags = ["reddit-app"]
}

