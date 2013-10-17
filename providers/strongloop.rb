include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do

  include_recipe 'strongloop::install_from_package'

  execute "slc npm install -g forever" do
    action :run
    not_if "which forever"
  end

  unless new_resource.restart_command
    new_resource.restart_command do

      service "#{new_resource.application.name}_strongloop" do
        provider Chef::Provider::Service::Upstart
        supports :restart => true, :start => true, :stop => true
        action [:enable, :restart]
      end

    end
  end

  new_resource.environment.update({
    'NODE_ENV' => new_resource.environment_name
  })

end

action :before_deploy do

  new_resource.environment['NODE_ENV'] = new_resource.environment_name

end

action :before_migrate do
  execute 'slc npm install' do
    cwd new_resource.release_path
    user new_resource.owner
    group new_resource.group
    environment new_resource.environment.merge({ 'HOME' => new_resource.shared_path })
  end

end

action :before_symlink do
end

action :before_restart do

  template "#{new_resource.application.name}.upstart.conf" do
    path "/etc/init/#{new_resource.application.name}_strongloop.conf"
    source new_resource.template ? new_resource.template : 'strongloop.upstart.conf.erb'
    cookbook new_resource.template ? new_resource.cookbook_name.to_s : 'application_nodejs'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      :user => new_resource.owner,
      :group => new_resource.group,
      # :node_dir => node['strongloop']['dir'],
      :app_dir => new_resource.release_path,
      :entry => new_resource.entry_point,
      :environment => new_resource.environment
    )
  end

end

action :after_restart do
end
