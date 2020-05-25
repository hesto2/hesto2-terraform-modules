variable "domain_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "regional_certificate_arn" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "apigateway_stage_name" {
  type = string
  default = "v1"
}

variable "filename" {
  type = string
}

variable "lambda_environment_variables" {
  type = map
}

variable "lambda_handler" {
  type = string
  default = "index.handler"
}
