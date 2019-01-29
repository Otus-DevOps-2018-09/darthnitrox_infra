variable public_key_path {
    description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable "network_name" {
  description = "Netork name"
  default = "default"
}

variable "firewall_db" {
  description = "Firewall db name"
  default = "allow-mongo-default"
}

variable "db_allow_ports" {
  description = "Allow port"
  default = ["27017"]
}

variable "allow_source_tags_instance" {
  description = "Tags on application"
  default = ["reddit-app"]
}

