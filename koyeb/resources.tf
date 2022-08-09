terraform {
  required_providers {
    koyeb = {
      source = "koyeb/koyeb"
    }
  }
}

provider "koyeb" {
}

resource "koyeb_secret" "mongo_uri" {
  name  = var.koyeb_mongo_uri_secret_name
  value = var.mongo_uri
}

resource "koyeb_app" "noted" {
  name = var.koyeb_app_name
}

resource "koyeb_service" "gateway" {
  app_name = var.koyeb_app_name

  definition {
    name = var.koyeb_api_gateway_service_name
    regions = ["par"]

    instance_types {
      type = "nano"
    }

    ports {
      port = 3000
      protocol = "http"
    }

    scalings {
      min = 1
      max = 1
    }

    env {
      key = "API_GATEWAY_ACCOUNTS_SERVICE_ADDR"
      value = "accounts.noted.koyeb:3000"
    }

    env {
      key = "API_GATEWAY_RECOMMENDATIONS_SERVICE_ADDR"
      value = "recommendations.noted.koyeb:3000"
    }

    routes {
      path = "/"
      port = 3000
    }

    docker {
      image = "rojasdiego/noted-api-gateway"
    }
  }

  depends_on = [
    koyeb_app.noted
  ]
}

resource "koyeb_service" "accounts" {
  app_name = var.koyeb_app_name

  definition {
    name = var.koyeb_accounts_service_name
    regions = ["par"]

    instance_types {
      type = "nano"
    }

    ports {
      port = 3000
      protocol = "tcp"
    }

    scalings {
      min = 1
      max = 1
    }

    env {
      key = "ACCOUNTS_SERVICE_MONGO_URI"
      secret = var.koyeb_mongo_uri_secret_name
    }

    docker {
      image = "rojasdiego/noted-accounts-service"
    }
  }

  depends_on = [
    koyeb_app.noted,
    koyeb_secret.mongo_uri
  ]
}
