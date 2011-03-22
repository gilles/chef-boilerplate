#system wide PS1 with a RED date on prod, YELLOW on staging
case node[:app_environment]
  when 'production' then
    color = '\[\e[0;31m\]'
  when 'staging' then
    color = '\[\e[0;33m\]'
  else
    color = ''
end
template "/etc/profile.d/prompt.sh" do
  source "prompt.sh.erb"
  mode "0644"
  owner "root"
  group "root"
  backup 0
  variables(
          :color => color
  )
end

#I want to handle PS1 system wide. Ubuntu makes it difficult. Plus the original -z PS1 check does not play nice with RVM
case node[:platform]
  when "ubuntu", "debian"
    cookbook_file "/etc/bash.bashrc" do
      source "bash.bashrc"
      mode "0644"
      owner "root"
      group "root"
      backup 0
    end
    cookbook_file "/etc/profile" do
      source "profile"
      mode "0644"
      owner "root"
      group "root"
      backup 0
    end
    cookbook_file "/etc/skel/.bashrc" do
      source "bashrc.skel"
      mode "0644"
      owner "root"
      group "root"
      backup 0
    end
end