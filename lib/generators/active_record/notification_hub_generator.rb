require 'rails/generators/active_record'
module ActiveRecord
  module Generators
    class NotificationHubGenerator < ActiveRecord::Generators::Base      
      argument :association_model, type: :string, default: "user"
      argument :name, type: :string, default: "dummy"      
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates the NotificationHub models and their migrations"

      def create_models_and_migrations      
        template "models/subscription.rb", "#{models_path}/notification_hub/subscription.rb", rails5?: rails5?  
        migration_template "migrations/subscriptions.rb", "#{migrations_path}/create_notification_hub_subscriptions.rb", migration_version: migration_version    
        
        template "models/device.rb", "#{models_path}/notification_hub/device.rb", rails5?: rails5?  
        migration_template "migrations/devices.rb", "#{migrations_path}/create_notification_hub_devices.rb", migration_version: migration_version            
        
        template "models/subscription_device.rb", "#{models_path}/notification_hub/subscription_device.rb", rails5?: rails5? 
        migration_template "migrations/subscription_devices.rb", "#{migrations_path}/create_notification_hub_subscription_devices.rb", migration_version: migration_version
      end

      def inject_content_to_user
        content = "has_many :notification_hub_subscriptions, class_name: 'NotificationHub::Subscription', dependent: :destroy\nhas_many :notification_hub_devices, class_name: 'NotificationHub::Device', dependent: :destroy"
        content = content.split("\n").map { |line| "  " + line } .join("\n") << "\n"

        inject_into_class("#{models_path}/#{association_model}.rb", association_model.classify, content) 
      end

      def rails5?
        Rails.version.start_with? '5'
      end 
 
      def migration_version
        if rails5?
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end

      def migrations_path
        @migrations_path ||= File.join("db", "migrate")
      end

      def models_path
        @models_path ||= File.join("app", "models")
      end
    end
  end
end
