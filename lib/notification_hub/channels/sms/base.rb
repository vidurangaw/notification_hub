module NotificationHub
	module Channels
		module Sms			
	    class Base
	    	def initialize(options)	   
		     	Sms.default_gateway = self.class.gateway_code
		     	options[:template_path] ||= "notification_hub/sms"
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