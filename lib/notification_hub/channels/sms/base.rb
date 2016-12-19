module NotificationHub
	module Channels
		module Sms			
	    class Base
	    	def initialize(options)	   
		     	NotificationHub::Channels::Sms.gateway = self.class.gateway_code
      		NotificationHub::Channels::Sms.options = options
      	end
	    end
	  end
  end
end