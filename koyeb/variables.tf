variable "koyeb_app_name" {
  default = "noted"
}

variable "koyeb_api_gateway_service_name" {
  default = "gateway"
}

variable "koyeb_accounts_service_name" {
  default = "accounts"
}

variable "koyeb_notes_service_name" {
  default = "notes"
}

variable "koyeb_recommendations_service_name" {
  default = "recommendations"
}

variable "koyeb_mongo_uri_secret_name" {
  default = "MONGO_URI"
}

variable "mongo_uri" {
  description = "Address of the remote MongoDB database"
  type = string
  sensitive = true
}
