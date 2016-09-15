module NotificationHub
	module Channels
		module Email			
	    class Base
	    	def initialize(configuration)	   
		     	NotificationHub::Channels::Email.default_gateway = self.class.gateway_code
      	end
	    end
	  end
  end
end