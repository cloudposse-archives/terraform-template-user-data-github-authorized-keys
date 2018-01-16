output "user_data" {
  value = "${data.template_file.default.rendered}"
  description = "A rendered content of the shell script"
}
