data "google_service_account" "compute_engine_default" {
    account_id = "${module.service_project.number}-compute@developer.gserviceaccount.com"
    project = module.service_project.project_id
}


resource "google_project_iam_member" "compute_engine_default_editor" {
    project = module.service_project.project_id
    role = "roles/editor"
    member = "serviceAccount:${data.google_service_account.compute_engine_default.email}"
}


resource "google_compute_project_metadata" "enable_oslogin" {
    project = module.service_project.project_id
    metadata = {
        "enable-oslogin" = "TRUE"
    }
}