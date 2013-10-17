include Chef::Resource::ApplicationBase

attribute :template, :kind_of => [String, NilClass], :default => nil
attribute :entry_point, :kind_of => String, :default => 'app.js'