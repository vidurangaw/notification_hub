require 'notification_hub/device_manager'

module NotificationHub
	module SubscriptionManager
	  class << self

			def create_subscription(association_model_id, event_code, channel_code, device_details=nil)
				subscription = NotificationHub::Subscription.
					where("#{NotificationHub.association_model}_id" => association_model_id, 
						event_code: event_code, channel_code: channel_code).first_or_create!

				if device_details
					device = NotificationHub::DeviceManager.create_device(association_model_id, channel_code, device_details)				
					
					NotificationHub::SubscriptionDevice.where(notification_hub_subscription_id: 
						subscription.id, notification_hub_device_id: device.id).first_or_create!
				end
				subscription
			end

			def update_subscription(id, event_code, channel_code, device_details)
				subscription = NotificationHub::Subscription.find(id)
				subscription.update_attributes!(event_code: event_code, channel_code: channel_code)
				if device_details
					subscription.notification_hub_subscription_devices.destroy_all
					association_model_id = eval("subscription.#{NotificationHub.association_model}.id")
					device = NotificationHub::DeviceManager.create_device(association_model_id, channel_code, device_details)				
					
					NotificationHub::SubscriptionDevice.where(notification_hub_subscription_id: 
						subscription.id, notification_hub_device_id: device.id).first_or_create!
				end
				subscription
			end

			def create_subscription_device(association_model_id, device_id, event_code, channel_code)
				subscription = NotificationHub::Subscription.
					where("#{NotificationHub.association_model}_id" => association_model_id, event_code: event_code, 
					channel_code: channel_code).first_or_create!

				subscription_device = NotificationHub::SubscriptionDevice.where(notification_hub_subscription_id: 
					subscription.id, notification_hub_device_id: device_id).first_or_create!

				subscription_device
			end

			def delete_subscription(id)
				NotificationHub::Subscription.find(id.to_i).destroy
			end

			def delete_subscription_device(id)
				NotificationHub::SubscriptionDevice.find(id.to_i).destroy
			end
		end	  
  end
end