module NotificationHub
	module Channels
		module Webhook		
	    class << self
				attr_accessor :gateway
				attr_accessor :options				

				def send_message(topic, data, options)
					options[:template_path] ||= "notification_hub/webhook"

					"NotificationHub::Channels::Webhook::#{gateway.to_s.camelize}".constantize.send_message(topic, data, options)
				end
			end
	  end
  end
end