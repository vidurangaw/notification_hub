module NotificationHub
	module Channels
		module Webhook			
	    class Base
	    	def initialize(options)	   
		     	Webhook.default_gateway = self.class.gateway_code
		     	options[:template_path] ||= "notification_hub/webhook"
		     	options[:timeout_time] ||= 10
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