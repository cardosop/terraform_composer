terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "5.5.0"
    }
  }
}

locals {
  project_id = "${var.project}-${var.environment}"
  impersonation_enabled_count = var.sa_enable_impersonation == true ? 1 : 0
}

data "google_secret_manager_secret_version" "credentials" {
  project = var.project
  secret = 	"airflow_sendgrid_api_key"
  version = "latest"
}

output "domain-admin-password" {
  value = data.google_secret_manager_secret_version.credentials.secret
}

provider "google-beta"{
  project = var.project
  #credentials = domain-admin-password.value
  region = var.region
}

resource "google_composer_environment" "composer" {
  provider = google-beta
  name = "composer-prod"
  project = var.project
  region = var.region
  
  
  config {
    software_config {
      image_version = var.composer_image_version
    }

    node_config {
      service_account = var.service_account
      network = var.network
      subnetwork = var.subnetwork
      #zone = var.zone

    }

    workloads_config {
      scheduler {
        cpu        = 2
        memory_gb  = 7.5
        storage_gb = 5
        count      = 2
      }
      web_server {
        cpu        = 2
        memory_gb  = 7.5
        storage_gb = 5
      }
      worker {
        cpu = 2
        memory_gb  = 7.5
        storage_gb = 5
        min_count  = 2
        max_count  = 6
      }
    }
    
    environment_size = "ENVIRONMENT_SIZE_MEDIUM"

  }
   
}

resource "google_project_iam_member" "composer_admin" {
  project = var.project
  role    = "roles/composer.admin"
  member  = "serviceAccount:terraform-sa@gcp-devops-402516.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "composer_worker" {
  project = var.project
  role    = "roles/composer.worker"
  member  = "serviceAccount:composer-sa@gcp-devops-402516.iam.gserviceaccount.com"
}