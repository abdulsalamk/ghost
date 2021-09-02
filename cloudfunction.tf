resource "google_storage_bucket" "bucket" {
    project = var.project_name
    name = "ghost-bucket-source"
  }
  
  resource "google_storage_bucket_object" "archive" {
    name   = "scripts.zip"
    bucket = google_storage_bucket.bucket.name
    source = "."
  }
  
  resource "google_cloudfunctions_function" "function" {
    name        = "ghost-posts"
    description = "Deletes all posts from the database"
    runtime     = "python39"
  
    available_memory_mb   = 128
    source_archive_bucket = google_storage_bucket.bucket.name
    source_archive_object = google_storage_bucket_object.archive.name
    trigger_http          = true
    timeout               = 60
    entry_point           = "delete"
    labels = {
      my-label = "my-label-value"
    }
  
    environment_variables = {
      MY_ENV_VAR = "my-env-var-value"
    }
  }
  
  # IAM entry for all users to invoke the function
  resource "google_cloudfunctions_function_iam_member" "invoker" {
    project        = google_cloudfunctions_function.function.project
    region         = google_cloudfunctions_function.function.region
    cloud_function = google_cloudfunctions_function.function.name

    role   = "roles/cloudfunctions.invoker"
    member = "allUsers"
  }