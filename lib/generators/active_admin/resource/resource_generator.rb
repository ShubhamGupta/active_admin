module ActiveAdmin
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      desc "Installs ActiveAdmin in a rails 3 application"

      def self.source_root
        @_active_admin_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def generate_config_file
        file = File.open('config/initializers/active_admin.rb')
        namespace_line = ""
        file.each_line do |line|
          namespace_line = line and break if !line.index('#') && line =~ /config.default_namespace/
        end
        # If namespace is not defined in active_admin.rb, use app/admin
        if namespace_line.strip!.blank?
          template "admin.rb", "app/admin/#{file_path.gsub('/', '_').pluralize}.rb"
        else
          new_namespace = namespace_line.split(' ')[-1].delete(":")
          template "admin.rb", "app/#{new_namespace}/#{file_path.gsub('/', '_').pluralize}.rb"
        end
      end

    end
  end
end
