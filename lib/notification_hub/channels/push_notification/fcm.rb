require 'fcm'
module NotificationHub
	module Channels
	  module PushNotification
	    class Fcm < Base
	      @@gateway_code = :fcm
	      @@client = :fcm

	      def initialize(configuration)	      	
      		@@client = FCM.new(configuration[:api_key]) 
	      	super
	      end

	      class << self
					def send_message(topic, data, options)						
						topic = topic.split(".")				

						json_string = ActionController::Base.new.
								render_to_string("#{options[:template_path]}/#{topic[0]}/#{topic[1]}", locals: data)
						json_object = JSON.parse(json_string)

						tokens = options[:tokens].present? ? options[:tokens] : [options[:token]]
						response = @@client.send(tokens, json_object)
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

					def gateway_code
						@@gateway_code
					end
				end
	    end
	  end
	end
end