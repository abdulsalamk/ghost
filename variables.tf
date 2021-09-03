variable "database_instance" {
    type = string
    default = "cloudrundb4"
}
variable "database_user" {
    type = string
    default = "cloudrun"
}
variable "database_password" {
type = string
default = "cloudrun"
}
variable "database_name" {
type = string
default = "cloudrundb"
}

variable "project_name" {
    type=string
    default = "ghost-blog-324611"    
}

variable "region" {
    type=string
    default = "europe-west2"
}

variable "network_name" {
    type=string
    default = "drone-network"
}
variable "repository_name" {
    type=string
    default = "config-app"
}
variable "branch_name" {
    type=string
    default = "master"
}
variable "service_name" {
  description = "The name of the Cloud Run service to deploy."
  type        = string
  default     = "config-service"
}

variable "service_account_name" {
  description = "The name of the Service Account."
  type        = string
  default     = "config-service"
}

variable "dockerImage" {
    type=string
    default = "gcr.io/ghost-blog-324611/ghost@sha256:4048f1a038c34f1b613fc09cc23cd2fcfad9a14db1ac617b417c529ecea43f17"
}