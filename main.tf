locals {
  template_path = "${path.module}/templates/${var.os}.sh"
}

data "template_file" "default" {
  template = "${file(local.template_path)}"

  vars {
    github_api_token    = "${var.github_api_token}"
    github_organization = "${var.github_organization}"
    github_team         = "${var.github_team}"
  }
}