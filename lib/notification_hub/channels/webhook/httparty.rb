module NotificationHub
	module Channels
		module Webhook			
	    class Httparty < Base
		    @gateway_code = :httparty

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event_id, data, options)					
						event = event_id.split(".")			
						
						begin		
							json_string = ActionController::Base.new.
								render_to_string("#{gateway_options[:template_path]}/#{event[0]}/#{event[1]}", locals: data)
							json_object = JSON.parse(json_string)
							json_object[:event] = event_id

							response = HTTParty.post(options[:webhook_url], { 
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
				end
			end
	  end
  end
end