variable "composer_image_version" {
  type    = string
  default = "composer-2.4.6-airflow-2.5.3"
}

variable "project" {
  type    = string
  default = "gcp-devops-402516"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "service_account" {
  type    = string
  default = "terraform-sa@gcp-devops-402516.iam.gserviceaccount.com"
}

variable "sa2" {
  type    = string
  default = "composer-sa@gcp-devops-402516.iam.gserviceaccount.com"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "network" {
  type    = string
  default = "default"
}

variable "subnetwork" {
  type    = string
  default = "default"
}

variable "disk_size_gb_default" {
  type    = number
  default = 2
}

variable "sa_enable_impersonation" {
  description = "Allow org_admins group to impersonate service account & enable APIs required."
  type        = bool
  default     = false
}
#