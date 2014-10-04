class { 'ruby':
  gems_version  => 'latest'
}

class { 'nginx': }

class { 'postgresql::server': }

class { 'redis': }

class { gitlab:
  puppet_manage_config => true,
  gitlab_branch => '7.3.2',  # ensure version is compatible with installed Puppet module (see https://about.gitlab.com/blog/ for latest version)
  external_url => 'http://gitlab.test',
}
