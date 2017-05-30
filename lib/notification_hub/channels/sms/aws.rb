require 'notification_hub/channels/sms/base'

module NotificationHub
	module Channels
	  module Sms
	    class Aws < Base
	      @gateway_code = :aws

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event_code, data, options)						
						event = event_code.split(".")

						begin 
							string = ActionController::Base.new.
									render_to_string("#{gateway_options[:template_path]}/#{event[0]}/#{event[1]}", locals: data)

							sns_client = ::Aws::SNS::Client.new
	      			sns_client.publish(phone_number: options[:phone_number].gsub(/[^0-9]+/, ''), 
	      				message: string)      			
      			rescue => exception
						  raise "Sms::Aws Error: #{exception.message}"
						end
					end
				end
	    end
	  end
	end
end