# @summary Manage the needed services for NFS server.
#
# @author
#   * Daniel Klockenkaemper <dk@marketing-factory.de>
#   * Martin Alfke <tuxmea@gmail.com>
#
class nfs::server::service {
  if $nfs::nfs_v4 == true {
    if $nfs::server_nfsv4_servicehelper != undef and $nfs::manage_server_servicehelper {
      $server_service_require = Service[$nfs::server_nfsv4_servicehelper]
      $nfs::server_nfsv4_servicehelper.each |$service_name| {
        service { $service_name:
          ensure     => $nfs::server_service_ensure,
          enable     => $nfs::server_service_enable,
          hasrestart => $nfs::server_service_hasrestart,
          hasstatus  => $nfs::server_service_hasstatus,
          subscribe  => [Concat[$nfs::exports_file], Augeas[$nfs::idmapd_file]],
        }
      }
    } else {
      $server_service_require = undef
    }

    if $nfs::manage_server_service {
      service { $nfs::server_service_name:
        ensure     => $nfs::server_service_ensure,
        enable     => $nfs::server_service_enable,
        hasrestart => $nfs::server_service_hasrestart,
        hasstatus  => $nfs::server_service_hasstatus,
        restart    => $nfs::server_service_restart_cmd,
        subscribe  => [Concat[$nfs::exports_file], Augeas[$nfs::idmapd_file]],
        require    => $server_service_require,
      }
    }
  } else {
    if $nfs::manage_server_service {
      service { $nfs::server_service_name:
        ensure     => $nfs::server_service_ensure,
        enable     => $nfs::server_service_enable,
        hasrestart => $nfs::server_service_hasrestart,
        hasstatus  => $nfs::server_service_hasstatus,
        restart    => $nfs::server_service_restart_cmd,
        subscribe  => Concat[$nfs::exports_file],
      }
    }
  }
}
