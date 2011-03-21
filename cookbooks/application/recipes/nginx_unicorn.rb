app = node.run_state[:current_app]

#unicorn
include_recipe "application::unicorn"

#nginx
include_recipe 'nginx'

#nginx/unicorn proxy
socket = "/tmp/unicorn_#{app['id']}.sock"

template "#{node[:nginx][:dir]}/sites-available/#{app['id']}" do
  source "unicorn_nginx_site.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
          :docroot => File.join(app['deploy_to'], 'current', 'public'),
          :socket => socket,
          :opts => app['nginx']
  )
  notifies :restart, resources(:service => "nginx")
end
nginx_site app['id']
