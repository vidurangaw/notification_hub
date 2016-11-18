module NotificationHub
	module Channels
		module Webhook		
	    class << self
				attr_accessor :gateway
				attr_accessor :options				

				def send_message(event, data, options)
					"NotificationHub::Channels::Webhook::#{gateway.to_s.camelize}".constantize.send_message(event, data, options)
				end
			end
	  end
  end
end