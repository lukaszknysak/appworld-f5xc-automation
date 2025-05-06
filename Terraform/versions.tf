terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.43"
    }
  }
}
provider "volterra" {
  api_p12_file = var.api_p12
  url          = "https://${var.tenant_name}.console.ves.volterra.io/api"
}


