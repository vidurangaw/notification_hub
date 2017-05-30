require 'notification_hub/channels/email/action_mailer'

module NotificationHub
	module Channels
		module Email			
	    class << self
				attr_accessor :default_gateway	

				def send_message(event_code, data, options, gateway = nil)
					gateway ||= default_gateway
					"NotificationHub::Channels::Email::#{gateway.to_s.camelize}".constantize.send_message(event_code, data, options)
				end
			end
	  end
  end
end
  
