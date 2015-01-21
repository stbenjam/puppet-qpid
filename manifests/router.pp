# == Class: qpid::router
#
# Handles Qpid dispatch router package installations and configuration
#
class qpid::router(
  $router_id               = $qpid::router::params::router_id,
  $mode                    = $qpid::router::params::mode,

  $config_file             = $qpid::router::params::config_file,

  $container_name          = $qpid::router::params::container_name,

  $ssl                     = $qpid::router::params::ssl,
  $ssl_profile_name        = $qpid::router::params::ssl_profile_name,
  $ssl_ca_cert             = $qpid::router::params::ssl_ca_cert,
  $ssl_cert                = $qpid::router::params::ssl_cert,
  $ssl_key                 = $qpid::router::params::ssl_key,

  $hub                     = $qpid::router::params::hub,
  $hub_addr                = $qpid::router::params::hub_addr,
  $hub_port                = $qpid::router::params::hub_port,
  $hub_sasl_mech           = $qpid::router::params::hub_sasl_mech,
  $hub_role                = $qpid::router::params::hub_role,

  $listener                = $qpid::router::params::listener,
  $listener_addr           = $qpid::router::params::listener_addr,
  $listener_port           = $qpid::router::params::listener_port,
  $listener_sasl_mech      = $qpid::router::params::listener_sasl_mech,
  $listener_role           = $qpid::router::params::listener_role,

  $connector                = $qpid::router::params::connector,
  $connector_name           = $qpid::router::params::connector_name,
  $connector_addr           = $qpid::router::params::connector_addr,
  $connector_port           = $qpid::router::params::connector_port,
  $connector_sasl_mech      = $qpid::router::params::connector_sasl_mech,
  $connector_role           = $qpid::router::params::connector_role,
) inherits qpid::router::params {

  class { 'qpid::router::install': } ~>
  class { 'qpid::router::config': }

}
