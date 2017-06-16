# Includes oauth2_proxy
#
# Recipe:: install
# Cookbook:: oauth2_proxy
# Author:: Mike Juarez <mike@orionlabs.co>
# License:: Apache License, Version 2.0
# Source:: https://github.com/orion-cookbooks/oauth2_proxy
#

include_recipe 'ark'
include_recipe 'pleaserun::default'

#ark 'oauth2_proxy' do
#  url node['oauth2_proxy']['install_url']
#  checksum node['oauth2_proxy']['checksum']
#  path node['oauth2_proxy']['install_path']
#  action :install
#end

### Let's build the version from the source
package "golang-go"
directory "/tmp/go/src/github/bitly" do
    recursive true
end

git 'oauth2-proxy' do
    destination "/tmp/go/src/github/bitly/oauth2_proxy"
    repository  "https://github.com/kindlyops/oauth2_proxy.git"
    revision    "github-teams-tweaks"
    notifies    :run, "execute[Compile oauth2_proxy]", :immediate
end

execute "Compile oauth2_proxy" do
    command     "go get"
    environment ({ "GOPATH" => "/tmp/go"})
    cwd         "/tmp/go/src/github/bitly/oauth2_proxy"
    action      :nothing
end

directory node['oauth2_proxy']['config_files'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
