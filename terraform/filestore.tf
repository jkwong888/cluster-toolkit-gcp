# resource "google_compute_global_address" "psa_ip_range" {
#   project = data.google_project.host_project.project_id

#   name          = "filestore-psa-range"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 24 # Example: /24 CIDR block

#   network       = data.google_compute_network.shared_vpc.id
# }

# resource "google_service_networking_connection" "filestore_connection" {
#   network                 = data.google_compute_network.shared_vpc.id
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
# }

resource "google_filestore_instance" "instance" {
  provider = google-beta
  project = module.service_project.project_id

  name     = "homedirs"
  location = "us-central1-b"
  protocol = "NFS_V3"
  tier     = "ZONAL"

  file_shares {
    capacity_gb = 1024
    name        = "homedirs"

  }

  networks {
    network = data.google_compute_network.shared_vpc.id
    connect_mode = "PRIVATE_SERVICE_ACCESS"
    # reserved_ip_range = google_compute_global_address.psa_ip_range.name
    reserved_ip_range = "google-managed-ip-range-2"

    # connect_mode = "PRIVATE_SERVICE_CONNECT"
    modes   = ["MODE_IPV4"]

    # psc_config {
    #     endpoint_project = module.service_project.project_id
    # }
  }
}