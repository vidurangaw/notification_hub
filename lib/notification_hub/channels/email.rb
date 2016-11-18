module NotificationHub
	module Channels
		module Email			
	    #@default_gateway = :action_mailer
	    
	    class << self
				attr_accessor :gateway		
				attr_accessor :options	

				def send_message(event, data, options)
					"NotificationHub::Channels::Email::#{gateway.to_s.camelize}".constantize.send_message(event, data, options)
				end

				# def default_gateway
				# 	@default_gateway
				# end
			end
	  end
  end
end
  
