module NotificationHub
	module Channels
		module Webhook			
	    class Httparty < Base
		    @@gateway_code = :httparty

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event, data, options)					
						event_ = event.split(".")			
						begin		
							json_string = ActionController::Base.new.
								render_to_string("notification_hub/webhook/#{event_[0]}/#{event_[1]}", locals: data)
							json_object = JSON.parse(json_string)
							json_object[:event] = event

							response = HTTParty.post(options[:url], { 
						    :body => json_object.to_json,
						    :headers => { 'Content-Type' => 'application/json' }
						  })											 
						rescue => exception
						  raise exception.message
						end

						case response.code
						when 200
						  puts "Success"
						else
						  raise response.message
						end	
					end

					def gateway_code
						@@gateway_code
					end					
				end
			end
	  end
  end
end