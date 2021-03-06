# learning locker database role
class learninglocker::db (
  $port = 27017,
  $database = 'learninglocker',
  $username = 'learninglocker',
  $password = 'learninglocker'
) {
  class {'::mongodb::globals':
    manage_package_repo => true,
    bind_ip             => '0.0.0.0',
  }->

  class {'::mongodb::server':
    port => $port,
  }->

  class {'::mongodb::client':} ->

  mongodb::db { $database:
    user     => $username,
    password => $password,
  }

  firewall { '200 allow database access':
    port   => [$port],
    proto  => tcp,
    action => accept,
  }
}
