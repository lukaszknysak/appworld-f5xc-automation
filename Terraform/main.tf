# Get data on the LB being created
data "volterra_http_loadbalancer_state" "lb-state" {
  name      = volterra_http_loadbalancer.http-lb.name
  namespace = var.namespace
}

# Create Health Check
resource "volterra_healthcheck" "http-health-check" {
  name      = "${var.namespace}-http-hc"
  namespace = var.namespace

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
    use_http2              = false
    expected_status_codes  = ["200"]
  }

  timeout             = 3
  interval            = 15
  unhealthy_threshold = 1
  healthy_threshold   = 3
  jitter_percent      = 30
}

# Create Origin Pool
resource "volterra_origin_pool" "http-origin-pool" {
  name      = "${var.namespace}-tf-pool"
  namespace = var.namespace

  origin_servers {

    public_name {
      dns_name = "appedge.one"
    }

    labels = {}
  }

  use_tls {
    use_host_header_as_sni = true
    tls_config {
      default_security = true
    }
    volterra_trusted_ca = true
    no_mtls             = true
  }
  port                  = 443
  same_as_endpoint_port = true
  healthcheck {
    namespace = var.namespace
    name      = volterra_healthcheck.http-health-check.name

  }
  loadbalancer_algorithm = "LB_OVERRIDE"
  endpoint_selection     = "LOCALPREFERED"
}

# Create Load Balancer
resource "volterra_http_loadbalancer" "http-lb" {
  name        = "${var.namespace}-tf-http-lb"
  namespace   = var.namespace
  labels      = {}
  annotations = {}
  domains     = ["${var.namespace}-tf.netoro.pl"]

  http {
    dns_volterra_managed = false
    port = 80
  }

  default_route_pools {
    pool {
      name      = volterra_origin_pool.http-origin-pool.name
      namespace = var.namespace
    }
    weight           = 1
    priority         = 1
    endpoint_subsets = {}
  }

  advertise_on_public_default_vip = true

  disable_api_definition           = true
  disable_waf                      = true
  add_location                     = true
  no_challenge                     = true
  user_id_client_ip                = true
  disable_rate_limit               = true
  service_policies_from_namespace  = true
  round_robin                      = true
  disable_trust_client_ip_headers  = true
  disable_malicious_user_detection = true
  disable_api_discovery            = true
  disable_bot_defense              = true
  disable_ip_reputation            = true
  disable_client_side_defense      = true
  no_service_policies              = true
  source_ip_stickiness             = true
}