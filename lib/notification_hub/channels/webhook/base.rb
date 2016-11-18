module NotificationHub
	module Channels
		module Webhook			
	    class Base
	    	def initialize(options)	   
		     	NotificationHub::Channels::Webhook.gateway = self.class.gateway_code
      		NotificationHub::Channels::Webhook.options = options
      	end
	    end
	  end
  end
end