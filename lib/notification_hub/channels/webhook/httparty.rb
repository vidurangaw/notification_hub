require 'notification_hub/channels/webhook/base'

module NotificationHub
	module Channels
		module Webhook			
	    class Httparty < Base
		    @gateway_code = :httparty

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event_code, data, options)					
						event = event_code.split(".")			
						
						begin		
							json_string = ActionController::Base.new.
								render_to_string("#{gateway_options[:template_path]}/#{event[0]}/#{event[1]}", locals: data)
							json_object = JSON.parse(json_string)
							json_object[:event] = event_code
							json_object[:timestamp] = Time.zone.now

							response = HTTParty.post(options[:webhook_url], { 
						    :body => json_object.to_json,
						    :headers => { 'Content-Type' => 'application/json' },
						    :timeout => gateway_options[:timeout_time]
						  })

						  raise "Webhook::Httparty Error: #{response.body}" if response.code != 200
						rescue => exception
						  raise "Webhook::Httparty Error Error: #{exception.message}"
						end						
					end				
				end
			end
	  end
  end
end