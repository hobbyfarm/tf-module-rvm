variable "public_key" {}
variable "cpu" {}
variable "memory" {}
variable "disk" {}
variable "image" {}
variable "endpoint" {}
variable "name" {}

provider "ranchervm" {
	endpoint = "${var.endpoint}"
}

resource ranchervm_credential "test-cred" {
  name = "${var.name}"
  public_key = "${var.public_key}"
}

resource ranchervm_instance "test" {
  name = "${var.name}"
  cpu = "${var.cpu}"
  memory = "${var.memory}"
  image = "${var.image}"
  public_keys = ["${ranchervm_credential.test-cred.name}"]
  novnc = false
}

output "private_ip" {
  value = "${ranchervm_instance.test.*.ip}"
}