# oauth2_proxy attributes
#
# Attributes:: default
# Cookbook:: oauth2_proxy
# Author:: Mike Juarez <mike@orionlabs.co>
# License:: Apache License, Version 2.0
# Source:: https://github.com/orion-cookbooks/oauth2_proxy
#

#default['oauth2_proxy']['install_url']  = 'https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz'
#default['oauth2_proxy']['checksum']     = '1c16698ed0c85aa47aeb80e608f723835d9d1a8b98bd9ae36a514826b3acce56'
default['oauth2_proxy']['install_url']  = 'https://github.com/pusher/oauth2_proxy/releases/download/v3.1.0/oauth2_proxy-v3.1.0.linux-amd64.go1.11.tar.gz'
default['oauth2_proxy']['install_path'] = '/usr/local/oauth2_proxy'
default['oauth2_proxy']['checksum']     = 'adef7be37522b3a8b2a984402c565498da280c518d4d34ed3698274098d55472'
default['oauth2_proxy']['config_files'] = '/etc/oauth2_proxy/'
default['oauth2_proxy']['go_path']      = '/tmp/go'
