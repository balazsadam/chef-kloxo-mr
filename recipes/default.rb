#
# Cookbook Name:: kloxo-mr
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'yum-centos'

execute 'yum-update' do
  command 'yum update -y'
end

selinux_state "Selinux Disabled" do
  action :disabled
end

remote_file '/tmp/mratwork-release-0.0.1-1.noarch.rpm' do
  source 'https://github.com/mustafaramadhan/kloxo/raw/rpms/release/neutral/noarch/mratwork-release-0.0.1-1.noarch.rpm'
  action :create
end

package '/tmp/mratwork-release-0.0.1-1.noarch.rpm' do
  action :install
end

execute 'yum-clean' do
  command 'yum clean all'
end

package 'mratwork-release' do
  action :upgrade
end

package 'kloxomr7' do
  action :install
end

execute 'upcp' do
  command 'sh /script/upcp -y 2>/dev/null'
  returns 127
end
