module NotificationHub
	module Channels
		module Webhook			
	    class Httparty < Base
		    @@gateway_code = :httparty

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(topic, data, options)					
						topic_ = topic.split(".")			
						
						begin		
							json_string = ActionController::Base.new.
								render_to_string("#{options[:template_path]}/#{topic_[0]}/#{topic_[1]}", locals: data)
							json_object = JSON.parse(json_string)
							json_object[:topic] = topic

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