variable "github_api_token" {
  description = "GitHub API Token"
}

variable "github_organization" {
  description = "GitHub Organization Containing Team"
}

variable "github_team" {
  description = "GitHub Team for Membership to Grant SSH Access"
}

variable "os" {
  default     = "ubuntu"
  description = "Server OS that will execute user data script"
}
