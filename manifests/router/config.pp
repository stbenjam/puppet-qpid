# == Class: qpid::router::configure
#
# Handles Qpid router configuration
#
class qpid::router::config {
  file { $qpid::router::config_file:
    ensure  => file,
    content => template('qpid/qdrouterd.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
