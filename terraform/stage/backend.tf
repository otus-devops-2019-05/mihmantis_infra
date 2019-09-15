terraform {
  backend "gcs" {
    bucket = "mihmantis-infra-state-storage-bucket"
    prefix = "global/state-storage-bucket"
  }
}
