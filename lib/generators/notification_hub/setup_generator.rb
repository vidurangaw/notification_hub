module NotificationHub
  module Generators
    class SetupGenerator < Rails::Generators::Base 
      source_root File.expand_path("../templates", __FILE__)
      
      desc "Creates the models"
      hook_for :orm

      desc "Creates the notification template directories"
      def create_template_directories
        empty_directory "app/views/notification_hub/sms"
        empty_directory "app/views/notification_hub/push_notification"
        empty_directory "app/views/notification_hub/webhook"
      end
    end
  end
end
