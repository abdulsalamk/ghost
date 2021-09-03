resource "google_sql_database_instance" "master" {
  name             = var.database_instance
  database_version = "MYSQL_5_7"
  region           = var.region
  project  = var.project_name
  deletion_protection = false

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"    
    availability_type = "REGIONAL"   
    backup_configuration {
      enabled = true
      binary_log_enabled = true
    }
  }
}
  resource "google_sql_user" "users" {
  project  = var.project_name
  name     = var.database_user
  instance = google_sql_database_instance.master.name
  password = var.database_password
 }
