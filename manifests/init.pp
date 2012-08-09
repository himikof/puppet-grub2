import 'stdlib'

# Class grub2
#
#  Provides the GRUB 2.x bootloader
#
# @author Nikita Ofitserov <himikof@gmail.com>
# @version 1.0
# @package grub2
#
class grub2 (
  $device,
  $platforms = ["pc"],
  $default = 0,
  $timeout = 5,
  $distributor = "`lsb_release -i -s 2> /dev/null || echo Unknown`",
  $cmdline_linux_default = "quiet",
  $cmdline_linux = "",
  $badram = false,
  $terminal = false,
  $serial_command = false,
  $gfxmode = false,
  $disable_linux_uuid = false,
  $disable_linux_recovery = false,
  $init_tune = false,
) {
  # Package installation
  case $operatingsystem {
    gentoo:
    {
      portage::keywords { 'grub2':
        context  => 'grub2_grub2',
        package  => '~sys-boot/grub-2.00',
        tag      => 'buildhost'
      }
      $platforms_str = join($platforms, ' ')
      portage::make_conf_fragment { 'grub_platforms':
        value => "GRUB_PLATFORMS=\"${platforms_str}\"",
      }
      package { 'grub2':
        category => 'sys-boot',
        name     => 'grub',
        ensure   => 'latest',
        tag      => 'buildhost',
        require  => [
          Portage::Keywords['grub2'], 
          Portage::Make_conf_fragment['grub_platforms'],
        ],
        notify   => Exec['grub-install'],
      }

      $grub_install = '/usr/sbin/grub2-install'

      file { '/usr/sbin/update-grub':
        ensure  => 'present',
        owner   => root,
        group   => root,
        mode    => 0755,
        source  => 'puppet:///modules/grub2/update-grub.Gentoo',
      }

    }
  }
  
  file { '/etc/default/grub':
    content => template('grub2/default_grub.erb'),
    owner   => root,
    group   => root,
    mode    => 0644,
    require => Package['grub2'],
    notify  => Exec['update-grub'],
  }
  
  exec { 'grub-install':
    command     => "$grub_install $device",
    refreshonly => true,
    require     => Package['grub2'],
    notify      => Exec['update-grub'],
  }
  
  exec { 'update-grub':
    command     => '/usr/sbin/update-grub',
    refreshonly => true,
    require     => File['/etc/default/grub'],
  }

}
 
