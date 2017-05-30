module NotificationHub
  module Generators 
    class NotificationHubGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :association_model, type: :string, default: "user"
      
      desc "Copy NotificationHub initializer"
      def copy_initializer       
        template "initializer.rb", "config/initializers/notification_hub.rb"
      end

      desc "Generate models and migrations"
      hook_for :orm

      desc "Generate notification template directories"
      def create_template_directories
        empty_directory "app/views/notification_hub/email"        
        empty_directory "app/views/notification_hub/browser_push_notification"
        empty_directory "app/views/notification_hub/mobile_push_notification"
        empty_directory "app/views/notification_hub/sms"
        empty_directory "app/views/notification_hub/webhook"
      end
    end    
  end
end
