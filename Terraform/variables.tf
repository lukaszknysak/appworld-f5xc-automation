variable "api_p12" {
  description = "REQUIRED: F5 Distributed Cloud API certificate file path"
  type        = string
  default     = "/PATH/certificate.cert"
}

#variable "api_cert" {
#            type = string
#            default = "./credentials/xc-api-cert.cert"
#}
        
#variable "api_key" {
#          type = string
#          default = "./credentials/xc-api-cert.key"
#}

variable "api_url" {
  description = "URL API F5 XC (np. https://<tenant>.console.ves.volterra.io/api)"
  type        = string
}

variable "tenant_name" {
  description = "REQUIRED: F5 Distributed Cloud tenant ID"
  type        = string
}

variable "namespace" {
  description = "REQUIRED: F5 Distributed Cloud namespace to deploy objects into"
  type        = string
  default     = "default"
}
