resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false

    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    #source      = "${path.module}/files/puma.service"
    content     = "${data.template_file.unit.rendered}"
    destination = "/tmp/puma.service"
  }

  #  provisioner "file" {
  #    source = "${path.module}/files/deploy.sh"
  #    destination = "/tmp/deploy.sh"
  #  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }

  #provisioner "remote-exec" {
  #  inline = [
  #    "sed s/[Service]/[Service]\nDATABASE_URL=${var.database_url}/g /etc/systemd/system/puma.service"
  #  ]
  #}
}

data "template_file" "unit" {
  template = "${file("${path.module}/files/puma.service")}"
  vars = {
    database_url = "${var.database_url}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"

    ports = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
