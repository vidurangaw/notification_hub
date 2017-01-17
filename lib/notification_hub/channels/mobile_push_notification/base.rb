module NotificationHub
	module Channels
		module MobilePushNotification			
	    class Base
	    	def initialize(options)     
	    		MobilePushNotification.default_gateway = self.class.gateway_code
	      	options[:template_path] ||= "notification_hub/mobile_push_notification"
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