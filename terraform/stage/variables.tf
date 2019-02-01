variable project {
  description = "silver-osprey-219908"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "~/.ssh/appuser.pub"
}

variable private_key_path {
  description = "~/.ssh/appuser"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base-timestamp"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base-1"
}
