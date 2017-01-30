module NotificationHub
	module Channels
		module Sms		
	    class << self
				attr_accessor :default_gateway			

				def send_message(event_code, data, options, gateway = nil)
					gateway ||= default_gateway
					"NotificationHub::Channels::Sms::#{default_gateway.to_s.camelize}".constantize.send_message(event_code, data, options)
				end
			end
	  end
  end
end