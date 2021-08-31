resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = var.region
  project  = var.project_name

  template {
    spec {
      containers {
        image = "gcr.io/ghost-blog-324611/ghost@sha256:4048f1a038c34f1b613fc09cc23cd2fcfad9a14db1ac617b417c529ecea43f17"
        ports {
          container_port = 2368
        }

        env {
          name  = "ENV"
          value = "production"
        }
        env {
          name  = "database__client"
          value = "mysql"
        }
        env {
          name  = "database__connection__user"
          value = var.database_user
        }
        env {
          name  = "database__connection__password"
          value = var.database_password
        }
        env {
          name  = "database__connection__database"
          value = var.database_name
        }
        env {
          name  = "database__connection__charset"
          value = "utf8mb4"
        }
        env {
          name  = "database__connection__socketPath"
          value = "/cloudsql/${var.project_name}:${var.region}:${var.database_instance}"
        }
        # env {
        #     # name="DB_URL"
        #     # value = "mysql://${var.database_user}:${var.database_password}@/${var.database_instance}?host=/cloudsql/ghost-blog-324611:europe-west2:cloudrundb2"
        # }
        env {
          name  = "URL"
          value = "https://cloudrun-srv-q2zyihw7bq-nw.a.run.app"
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/cloudsql-instances" = "${var.project_name}:${var.region}:${var.database_instance}"
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
    # metadata {
    #   annotations = {
    #     "run.googleapis.com/cloudsql-instances" = "ghost-blog-324611:europe-west2:cloudrundb2"
    #   }
    # }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
