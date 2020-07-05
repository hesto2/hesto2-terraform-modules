module "lambda" {
  source                       = "../lambda_app"
  app_name                     = var.app_name
  lambda_environment_variables = var.lambda_environment_variables
  log_retention_days           = var.log_retention_days
  filename                     = var.filename
  handler                      = var.handler
}