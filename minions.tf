resource "google_compute_instance" "salt_minions" {
  for_each = toset([
    "1",
    "2"
  ])
  name = "salt-minion-${each.value}"
  machine_type = "e2-standard-2"
  zone = var.zone
  allow_stopping_for_update = true
  depends_on = [google_compute_firewall.allow["ssh"]]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc.id
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_public_key_path)}"
  }
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = self.network_interface[0].access_config[0].nat_ip
      user = var.user
      timeout = "500s"
      private_key = file(var.ssh_private_key_path)
    }
    inline = [
      "sudo apt update",
      "sudo apt-get install python3 salt-common vim -y",
      "sudo apt-get install salt-minion -y",
      "echo \"master: ${var.master_ip}\" | sudo tee /etc/salt/minion",
      "echo \"master_finger: '${var.master_pub_key}'\" | sudo tee -a /etc/salt/minion",
      "sudo systemctl restart salt-minion"
    ]
  }
}
