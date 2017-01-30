module NotificationHub
	module Channels
		module MobilePushNotification		
	    class << self
				attr_accessor :default_gateway

				def send_message(event_code, data, options, gateway = nil)
					gateway ||= default_gateway			
					"NotificationHub::Channels::MobilePushNotification::#{gateway.to_s.camelize}".constantize.send_message(event_code, data, options)
				end
			end
	  end
  end
end