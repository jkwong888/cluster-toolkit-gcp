resource "google_project_organization_policy" "shielded_vm_disable" {
  project    = module.service_project.project_id
  constraint = "constraints/compute.requireShieldedVm"

  boolean_policy {
    enforced = false 
  }
}

resource "google_project_organization_policy" "oslogin_disable" {
  project    = module.service_project.project_id
  constraint = "constraints/compute.requireOsLogin"

  boolean_policy {
    enforced = false 
  }
}


resource "google_project_organization_policy" "trustedImageProjects" {
  project    = module.service_project.project_id
  constraint = "constraints/compute.trustedImageProjects"

  list_policy {
    allow {
      values = [
        "projects/schedmd-slurm-public",
      ]
    }
  }
}