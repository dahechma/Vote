variable "app_name" {
  description = "Name of the voting application"
  type        = string
  default     = "voting-app"
}

variable "vote_port" {
  description = "Port for vote service"
  type        = number
  default     = 5000
}

variable "result_port" {
  description = "Port for result service"
  type        = number
  default     = 5001
}