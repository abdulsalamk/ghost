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