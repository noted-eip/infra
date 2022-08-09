data "koyeb_secret" "mongo_uri" {
  name = "MONGO_URI"
}

data "koyeb_app" "noted" {
  name = var.koyeb_app_name
}

data "koyeb_service" "gateway" {
  slug = format("%s/%s", var.koyeb_app_name, var.koyeb_api_gateway_service_name)
}

data "koyeb_service" "accounts" {
  slug = format("%s/%s", var.koyeb_app_name, var.koyeb_accounts_service_name)
}
