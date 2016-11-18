module NotificationHub
	module Workers	 
		@default_worker = :real_time

    class << self
			attr_accessor :default_worker		

			# def send_message(topic, variables, gateway)	
			# 	gateway_ = gateway || default_gateway
			# 	"NotificationHub::Channels::Email::#{gateway_.to_s.camelize}".constantize.send_message(topic, variables)
			# end

			def default_gateway
				@default_worker
			end
		end
	  
  end
end