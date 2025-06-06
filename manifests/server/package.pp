# @summary Install needed packages for NFS server.
#
# @author
#   * Daniel Klockenkaemper <dk@marketing-factory.de>
#   * Martin Alfke <tuxmea@gmail.com>
#
class nfs::server::package {
  if $nfs::manage_packages {
    if $nfs::manage_server_service {
      $notify_services = Service[$nfs::server_service_name]
    } else {
      $notify_services = undef
    }

    package { $nfs::server_packages:
      ensure => $nfs::server_package_ensure,
      notify => $notify_services,
    }
  }
}
