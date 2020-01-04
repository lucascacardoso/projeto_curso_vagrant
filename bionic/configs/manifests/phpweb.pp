# O recurso que executa o apt-get update é chamado de 'apt-update'
exec { 'apt-update':
  command => '/usr/bin/apt-get update'
}

# Atualiza os pacotes, instala 'php7.2' e 'php7.2-mysql' e confirma se foram instalados
package { ['php7.2', 'php7.2-mysql']:
  require => Exec['apt-update'],
  ensure => installed,
}

# Depois de garantir que o pacote 'php7.2' foi instalado, executa o comando em bg que sobe o php na porta 8888
# e aponta para os códigos php disponíveis em /vagrant/src
exec { 'run-php7':
  require => Package['php7.2'],
  command => '/usr/bin/php -S 0.0.0.0:8888 -t /vagrant/src &'
}
