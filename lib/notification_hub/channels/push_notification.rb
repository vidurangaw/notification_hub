module NotificationHub
	module Channels
		module PushNotification		
	    class << self
				attr_accessor :gateway
				attr_accessor :options				

				def send_message(topic, data, options)
					options[:template_path] ||= "notification_hub/push_notification"

					"NotificationHub::Channels::PushNotification::#{gateway.to_s.camelize}".constantize.send_message(topic, data, options)
				end
			end
	  end
  end
end