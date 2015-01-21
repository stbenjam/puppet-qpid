# == Class: qpid::router::params
#
# Default parameter values
#
class qpid::router::params {
  $config_file         = '/etc/qpid-dispatch/qdrouterd.conf'

  $router_id           = $::fqdn
  $router_mode         = 'interior'

  $container_name      = $::fqdn
  $worker_threads      = $::processorcount

  $ssl                 = false
  $ssl_profile_name    = 'router-ssl'
  $ssl_ca_cert         = undef
  $ssl_cert            = undef
  $ssl_key             = undef
  $ssl_password        = ''

  $hub                 = false
  $hub_ssl             = true
  $hub_addr            = '0.0.0.0'
  $hub_port            = 9672
  $hub_sasl_mech       = 'ANONYMOUS'
  $hub_role            = 'inter-router'

  $listener            = true
  $listener_ssl        = true
  $listener_addr       = '0.0.0.0'
  $listener_port       = 5672
  $listener_sasl_mech  = 'ANONYMOUS'
  $listener_role       = undef

  $connector            = false
  $connector_ssl        = true
  $connector_name       = 'broker'
  $connector_addr       = '0.0.0.0'
  $connector_port       = 5672
  $connector_sasl_mech  = 'ANONYMOUS'
  $connector_role       = 'on-demand'
}
