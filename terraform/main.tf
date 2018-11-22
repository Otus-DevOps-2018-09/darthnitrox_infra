provider "google"{
    version="1.4.0"
    project="silver-osprey-219908"
    region="europe-west1"
}
resource "google_compute_firewall" "firewall_puma"  {
     name="allow-puma-default"
     network="default"

     allow {
            protocol="tcp"
            ports=["9292"]
     } 

     source_ranges=["0.0.0.0/0"]
     target_tags=["reddit-app"]
 }

resource "google_compute_instance" "app" {
    name="reddit-app-1"
    machine_type="g1-small"
    zone="europe-west1-b"
    metadata{
        ssh-keys="appuser:${file("~/.ssh/appuser.pub")}"
    }

    boot_disk {
        initialize_params {
            image="reddit-base"
        }
    }
    network_interface {
        network="default"
        access_config {}
    }

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

    provisioner "remote-exec" {
        script="files/deploy.sh"
    }

    tags=["reddit-app"]
}
