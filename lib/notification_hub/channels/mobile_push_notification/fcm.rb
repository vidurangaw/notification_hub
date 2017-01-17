require 'fcm'
module NotificationHub
	module Channels
	  module MobilePushNotification
	    class Fcm < Base
	    	@gateway_code = :fcm
				
				def initialize(options)	 
					self.class.client = FCM.new(options[:api_key]) 					
					super
	      end

	      class << self
	      	attr_accessor :client

					def send_message(event_id, data, options)						
						event = event_id.split(".")				

						json_string = ActionController::Base.new.
								render_to_string("#{gateway_options[:template_path]}/#{event[0]}/#{event[1]}", locals: data)
						json_object = JSON.parse(json_string)

						tokens = options[:push_tokens].present? ? options[:push_tokens] : [options[:push_token]]
						response = client.send(tokens, json_object)
			      case response[:status_code]
			      when 200     
			        response_body = JSON.parse(response[:body])
			        if response_body["failure"] == 1
			          raise response_body["results"][0]["error"]
			        end
			      else
			        raise response[:response]
			      end		
					end
				end
	    end
	  end
	end
end