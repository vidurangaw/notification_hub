require 'notification_hub/channels/mobile_push_notification/base'

module NotificationHub
	module Channels
	  module MobilePushNotification
	    class Fcm < Base
	    	@gateway_code = :fcm
				
				def initialize(options)	 					
					super
	      end

	      class << self      	
					def send_message(event_code, data, options)			
						event = event_code.split(".")				

						begin		
							json_string = ActionController::Base.new.
								render_to_string("#{gateway_options[:template_path]}/#{event[0]}/#{event[1]}", locals: data)
							json_object = JSON.parse(json_string)
							json_object[:to] = options[:push_token]
							json_object[:registration_ids] = options[:push_tokens]

							response = HTTParty.post("https://fcm.googleapis.com/fcm/send", { 
						    :body => json_object.to_json,
						    :headers => { 
						    	'Content-Type' => 'application/json',
						    	'Authorization' => "key=#{gateway_options[:server_key]}"
						    },
						    :timeout => gateway_options[:timeout_time]
						  })

						  raise "MobilePushNotification::Fcm Error: #{response.body}" if response.code != 200
						rescue => exception
						  raise "MobilePushNotification::Fcm Error: #{exception.message}"
						end						
					end
				end
	    end
	  end
	end
end