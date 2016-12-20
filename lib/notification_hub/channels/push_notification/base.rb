module NotificationHub
	module Channels
		module PushNotification			
	    class Base
	    	def initialize(options)	   
		     	NotificationHub::Channels::PushNotification.gateway = self.class.gateway_code
      		NotificationHub::Channels::PushNotification.options = options
      	end
	    end
	  end
  end
end