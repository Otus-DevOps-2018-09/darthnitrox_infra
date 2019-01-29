variable public_key_path {
  description = "~/.ssh/appuser.pub"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "network_name" {
  description = "Name network application"
  default = "default"
}

variable "application_firewall" {
  description = "Application allow firewall name"
  default = "allow-puma-default"
}

variable "app_firewall_source_port" {
  description = "Firewall allow ports"
  default = ["9292"]
}

variable "app_firewall_source_ip" {
  description = "Allow source ip address"
  default = ["0.0.0.0/0"]
}
