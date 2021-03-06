define ssl::certificate(
    $ensure = 'present',
    $source,
    $private_key = 'private_key.key',
    $all_in_one = '') {

    file { "/etc/ssl/${name}/":
        ensure  => $ensure ? {
            present => 'directory',
            default => $ensure,
        },
        source  => $source,
        recurse => true,
        purge   => true,
        force   => true,
        owner   => root,
        group   => root,
        mode    => 0644,
    }
    
    file { "/etc/ssl/${name}/${private_key}":
        ensure => $ensure,
        source => "${source}/${private_key}",
        owner  => root,
        group  => root,
        mode   => 0640,
    }
    
    if ($all_in_one) {
        file { "/etc/ssl/${name}/${all_in_one}":
            ensure => $ensure,
            source => "${source}/${all_in_one}",
            owner  => root,
            group  => root,
            mode   => 0640,
        }
    }
}