//network
resource "google_compute_network" "network" {
  name                    = "network"
  auto_create_subnetworks = "true"
}

//firewall
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
  name    = "network-firewall-http-ssh-rdp-icmp"
  network = google_compute_network.network.self_link
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

//mynet-us-vm instance
module "mynet-us-vm" {
  source           = "./instance"
  instance_name    = "mynet-us-vm"
  instance_zone    = "europe-west1-d"
  instance_network = google_compute_network.network.self_link
}

//mynet-eu-vm" instance
module "mynet-eu-vm" {
  source           = "./instance"
  instance_name    = "mynet-eu-vm"
  instance_zone    = "europe-west1-d"
  instance_network = google_compute_network.network.self_link
}
