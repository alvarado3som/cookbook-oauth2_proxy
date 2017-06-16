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
directory "#{node[:oauth2_proxy][:go_path]}/src/github.com/bitly" do
    recursive true
end

git 'oauth2-proxy' do
    destination "#{node[:oauth2_proxy][:go_path]}/src/github.com/bitly/oauth2_proxy"
    repository  "https://github.com/kindlyops/oauth2_proxy.git"
    revision    "github-teams-tweaks"
    notifies    :run, "execute[Get oauth2_proxy dependancies]", :immediate
    notifies    :run, "execute[Patch oauth2_proxy]", :immediate
    notifies    :run, "execute[Compile oauth2_proxy]", :immediate
end

execute "Get oauth2_proxy dependancies" do
    command     "go get"
    environment ({ "GOPATH" => "#{node[:oauth2_proxy][:go_path]}"})
    cwd         "#{node[:oauth2_proxy][:go_path]}/src/github.com/bitly/oauth2_proxy"
    action      :nothing
end

execute "Patch oauth2_proxy" do
    command "curl https://github.com/donaldguy/oauth2_proxy/commit/8965e6b58a3afd8ad9f0f326f91b25253c88d523.patch | git apply --apply"
    cwd     "#{node[:oauth2_proxy][:go_path]}/src/github.com/bitly/oauth2_proxy"
    action  :nothing
end

execute "Compile oauth2_proxy" do
    command     "go build"
    environment ({ "GOPATH" => "#{node[:oauth2_proxy][:go_path]}"})
    cwd         "#{node[:oauth2_proxy][:go_path]}/src/github.com/bitly/oauth2_proxy"
    action      :nothing
end

execute "Move compiled oauth2_proxy binary" do
    command "mv #{node[:oauth2_proxy][:go_path]}/src/github.com/bitly/oauth2_proxy/oauth2_proxy #{node['oauth2_proxy']['install_path']}"
    only_if "test -f #{node[:oauth2_proxy][:go_path]}/src/github.com/bitly/oauth2_proxy/oauth2_proxy"
end

directory node['oauth2_proxy']['config_files'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
