variable "app_name" {
  type = string
}

variable "filename" {
  type    = string
  default = "deploy.zip"
}
variable "lambda_environment_variables" {
  type    = map
  default = {}
}

variable "log_retention_days" {
  type    = number
  default = 7
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "runtime" {
  type    = string
  default = "nodejs20.x"
}

variable "s3_bucket" {
  type    = string
  default = null
}

variable "s3_key" {
  type    = string
  default = null
}