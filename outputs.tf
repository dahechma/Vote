output "vote_service_url" {
  value = "http://localhost:${var.vote_port}"
}

output "result_service_url" {
  value = "http://localhost:${var.result_port}"
}