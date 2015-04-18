#
# Uses Wildfly CLI Wrapper to ensure configuration state
#
define wildfly::util::cli($content = undef, $path = undef, $address = $wildfly::mgmt_bind) {

  $cleaned_content = delete_undef_values($content)
  $json_content = to_unescaped_json($cleaned_content)


  exec { $title:
    command => "java -jar ${wildfly::dirname}/bin/client/wildfly-cli-wrapper.jar --path \"${path}\" --content ${json_content} --target-address ${address}",
    unless  => "java -jar ${wildfly::dirname}/bin/client/wildfly-cli-wrapper.jar --path \"${path}\" --content ${json_content} --target-address ${address} --verify-only",
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin', "${wildfly::java_home}/bin"],
    require => Service['wildfly']
  }

}
