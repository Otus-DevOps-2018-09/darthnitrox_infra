variable "ssh_port" {
    description = "Port ssh"
    default = ["22"]
}

variable "source_ranges" {
  description = "Accept ssh connect for ip address"
  default = ["0.0.0.0/0"]
}
