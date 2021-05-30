#
# Cookbook:: geoiplookup
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

directory '/opt/geoip' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/opt/geoip/geoiplookup.sh' do
  owner 'root'
  group 'root'
  mode '744'
  content ::File.open('/opt/geoipfiles/geoiplookup.sh').read
  action :create
end

execute 'Get GeoIP info' do
  node.default['domains'] = 'www.reuters.com mail.sodoit.com www.download.windowsupdate.com resquare.ca www.ingrammicrocloud.com'
  command "/opt/geoip/geoiplookup.sh #{node['domains']} > /opt/geoip/result.txt"
end
