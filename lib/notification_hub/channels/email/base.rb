module NotificationHub
	module Channels
		module Email			
	    class Base
	    	def initialize(options)	   
		     	NotificationHub::Channels::Email.gateway = self.class.gateway_code
      		NotificationHub::Channels::Email.options = options
      	end
	    end
	  end
  end
end