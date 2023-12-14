terraform {
 backend "gcs" {
   bucket  = "tf-state-p8cardoso"
   prefix  = "terraform/state"
 }
}