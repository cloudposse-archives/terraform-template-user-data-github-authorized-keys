output "user_data" {
  value       = "${data.template_file.default.rendered}"
  description = "User data script that should be executed on startup"
}
