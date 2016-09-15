module NotificationHub
	module Channels
		module Email			
	    @default_gateway = :action_mailer
	    
	    class << self
				attr_accessor :default_gateway				

				def send_message(topic, variables, gateway)	
					gateway_ = gateway || default_gateway
					"NotificationHub::Channels::Email::#{gateway_.to_s.camelize}".constantize.send_message(topic, variables)
				end

				def default_gateway
					@default_gateway
				end
			end
	  end
  end
end