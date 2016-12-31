module NotificationHub
	module Channels
	  module Sms
	    class Aws < Base
	      @gateway_code = :aws

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event_id, data, options)						
						event = event_id.split(".")

						string = ActionController::Base.new.
								render_to_string("#{gateway_options[:template_path]}/#{event[0]}/#{event[1]}", locals: data)

						sns_client = ::Aws::SNS::Client.new
      			sns_client.publish(phone_number: options[:phone_number].gsub(/[^0-9]+/, ''), 
      				message: string)
					end
				end
	    end
	  end
	end
end