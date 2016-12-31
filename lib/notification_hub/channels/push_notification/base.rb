module NotificationHub
	module Channels
		module PushNotification			
	    class Base
	    	def initialize(options)     
	    		PushNotification.default_gateway = self.class.gateway_code
	      	options[:template_path] ||= "notification_hub/push_notification"
					self.class.gateway_options = options		     	
      	end

      	class << self    	
					attr_accessor :gateway_options
					attr_accessor :gateway_code
      	end
	    end
	  end
  end
end