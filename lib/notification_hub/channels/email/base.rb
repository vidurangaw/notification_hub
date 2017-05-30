module NotificationHub
	module Channels
		module Email			
	    class Base
	    	def initialize(options)	   
		     	Email.default_gateway = self.class.gateway_code
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