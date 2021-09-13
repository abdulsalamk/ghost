variable "database_instance" {
    type = string
}
variable "database_user" {
    type = string
}
variable "database_password" {
type = string
}
variable "database_name" {
type = string
}

variable "project_name" {
    type=string   
}

variable "region" {
    type=string
}

variable "network_name" {
    type=string
}
variable "repository_name" {
    type=string
}
variable "branch_name" {
    type=string
    default = "master"
}
variable "service_name" {
  description = "The name of the Cloud Run service to deploy."
  type        = string
}

variable "service_account_name" {
  description = "The name of the Service Account."
  type        = string
}

variable "dockerImage" {
    type=string
}