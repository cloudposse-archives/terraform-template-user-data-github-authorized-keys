variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = "string"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = "string"
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "github_api_token" {
  description = "GitHub API Token"
}

variable "github_organization" {
  description = "GitHub Organization Containing Team"
}

variable "github_team" {
  description = "GitHub Team for Membership to Grant SSH Access"
}

variable "flavor" {
  default     = "debian-systemd"
  description = "Flavor depends of OS and init system"
}
