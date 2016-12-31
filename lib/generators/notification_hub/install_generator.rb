module NotificationHub
  module Generators 
    MissingActiveRecordError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Creates the NotificationHub initializer"
      class_option :orm
      
      def copy_initializer
        unless options[:orm]
          raise MissingActiveRecordError, <<-ERROR.strip_heredoc
          Active Record must be set to install NotificationHub in your application.
          ERROR
        end

        template "initializer.rb", "config/initializers/notification_hub.rb"
      end
    end    
  end
end
