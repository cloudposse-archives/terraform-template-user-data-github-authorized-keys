data "template_file" "default" {
  template = "${file("${path.module}/user_data.sh")}"

  vars {
    github_api_token    = "${var.github_api_token}"
    github_organization = "${var.github_organization}"
    github_team         = "${var.github_team}"
  }
}