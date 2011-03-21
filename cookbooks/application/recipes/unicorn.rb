#
# Cookbook Name:: application
# Recipe:: unicorn 
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

app = node.run_state[:current_app] 

include_recipe "unicorn"

node.default[:unicorn][:worker_timeout] = 60
node.default[:unicorn][:preload_app] = false
node.default[:unicorn][:worker_processes] = [node[:cpu][:total].to_i * 4, 8].min
node.default[:unicorn][:preload_app] = false
node.default[:unicorn][:before_fork] = 'sleep 1' 
node.default[:unicorn][:port] = '8080'
node.set[:unicorn][:options] = { :tcp_nodelay => true, :backlog => 100 }

socket = "'/tmp/unicorn_#{app['id']}.sock'"

unicorn_config "/etc/unicorn/#{app['id']}.rb" do
  listen({ socket => node[:unicorn][:options] })
  working_directory ::File.join(app['deploy_to'], 'current')
  worker_timeout node[:unicorn][:worker_timeout] 
  preload_app node[:unicorn][:preload_app] 
  worker_processes node[:unicorn][:worker_processes]
  before_fork node[:unicorn][:before_fork]
  stderr_path File.join(app['deploy_to'], 'current', 'log/unicorn.stderr')
  stderr_path File.join(app['deploy_to'], 'current', 'log/unicorn.stdout')
end

include_recipe "god"

god_monitor app['id'] do
  config 'unicorn.god.erb'
  unicorn_config "/etc/unicorn/#{app['id']}.rb"
  app_environment node[:app_environment].to_s
  app_path File.join(app['deploy_to'], 'current')
  app app
end

#verify this
#if ::File.exists?(::File.join(app['deploy_to'], "current"))
#  d = resources(:deploy => app['id'])
#  d.restart_command do
#    execute "god restart unicorn_#{app['id']}"
#  end
#end
