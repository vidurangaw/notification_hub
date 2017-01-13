module NotificationHub
	module SubscriptionManager
	  class << self

			def create_subscription(user_id, event_id, channel_id, device_details=nil)
				subscription = NotificationHub::Subscription.
					where("#{NotificationHub.user_model}_id" => user_id, event_id: event_id, 
					channel_id: channel_id).first_or_create!
				
				if device_details
					device = NotificationHub::DeviceManager.create_device(user_id, device_details)				
					
					NotificationHub::SubscriptionDevice.where(notification_hub_subscription_id: 
						subscription.id, notification_hub_device_id: device.id).first_or_create!
				end
			end

			def update_subscription(id, event_id, channel_id, device_details)
				subscription = NotificationHub::Subscription.find(id)
				subscription.update!(event_id: event_id, channel_id: channel_id)
				if device_details
					subscription.notification_hub_subscription_devices.destroy_all
					user_id = eval("subscription.#{NotificationHub.user_model}.id")
					device = NotificationHub::DeviceManager.create_device(user_id, device_details)				
					
					NotificationHub::SubscriptionDevice.where(notification_hub_subscription_id: 
						subscription.id, notification_hub_device_id: device.id).first_or_create!
				end
			end

			def delete_subscription(id)
				NotificationHub::Subscription.find(id).destroy!
			end
		end	  
  end
end