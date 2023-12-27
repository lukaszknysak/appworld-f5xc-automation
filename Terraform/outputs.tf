output "http_lb_fqdn" {
  value = volterra_http_loadbalancer.http-lb.domains
}

output "http_lb_public_ip" {
    value = volterra_http_loadbalancer.http-lb.advertise_on_public_default_vip
}