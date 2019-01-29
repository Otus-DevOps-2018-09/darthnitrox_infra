provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source                   = "../modules/app"
  public_key_path          = "${var.public_key_path}"
  zone                     = "${var.zone}"
  app_disk_image           = "${var.app_disk_image}"
  network_name             = "default"
  application_firewall     = "allow-puma-default"
  app_firewall_source_port = ["9292"]
  app_firewall_source_ip   = ["0.0.0.0/0"]
}

module "db" {
  source                     = "../modules/db"
  public_key_path            = "${var.public_key_path}"
  zone                       = "${var.zone}"
  db_disk_image              = "${var.db_disk_image}"
  network_name               = "default"
  firewall_db                = "allow-mongo-default"
  db_allow_ports             = ["27017"]
  allow_source_tags_instance = ["reddit-app"]
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
