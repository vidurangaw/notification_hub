require 'rails/generators/active_record'
module ActiveRecord
  module Generators
    class SetupGenerator < ActiveRecord::Generators::Base
      argument :name, type: :string, default: ""
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates the NotificationHub models and their migrations"

      def create_models_and_migrations        
        template "models/subscription.rb", "app/models/notification_hub/subscription.rb", rails5?: rails5?  
        migration_template "migrations/subscriptions.rb", "db/migrate/create_notification_hub_subscriptions.rb", migration_version: migration_version    
        
        template "models/device.rb", "app/models/notification_hub/device.rb", rails5?: rails5?  
        migration_template "migrations/devices.rb", "db/migrate/create_notification_hub_devices.rb", migration_version: migration_version            
        
        template "models/subscription_device.rb", "app/models/notification_hub/subscription_device.rb", rails5?: rails5? 
        migration_template "migrations/subscription_devices.rb", "db/migrate/create_notification_hub_subscription_devices.rb", migration_version: migration_version
      end

      def inject_content_to_user
        content = "has_many :notification_hub_subscriptions, class_name: 'NotificationHub::Subscription', dependent: :destroy\nhas_many :notification_hub_devices, class_name: 'NotificationHub::Device', dependent: :destroy"
        content = content.split("\n").map { |line| "  " + line } .join("\n") << "\n"

        inject_into_class("app/models/#{user_model}.rb", NotificationHub.user_class, content) 
      end

      def rails5?
        Rails.version.start_with? '5'
      end 

      def user_model
        NotificationHub.user_class.downcase
      end     

      def migration_version
        if rails5?
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
