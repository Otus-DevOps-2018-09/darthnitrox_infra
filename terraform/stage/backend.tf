terraform {
  backend "gcs" {
      bucket = "storage-bucket-one"
      prefix = "tfstate_stage"
  }
}
