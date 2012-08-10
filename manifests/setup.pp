# Setup stage of grub2
class grub2::setup (
  $platforms,
) {
  case $operatingsystem {
    gentoo:
    {
      $platforms_str = join($platforms, ' ')
      portage::make_conf_fragment { 'grub_platforms':
        value => "GRUB_PLATFORMS=\"${platforms_str}\"",
      }
    }
  }

}