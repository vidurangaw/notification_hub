module NotificationHub
	module Channels
	  module Sms
	    class Aws < Base
	      @@gateway_code = :aws

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(topic, data, options)						
						topic = topic.split(".")

						string = ActionController::Base.new.
								render_to_string("#{options[:template_path]}/#{topic[0]}/#{topic[1]}", locals: data)

						sns_client = ::Aws::SNS::Client.new(::Aws.config)
      			sns_client.publish(phone_number: options[:phone_number].gsub(/[^0-9]+/, ''), 
      				message: string)
					end

					def gateway_code
						@@gateway_code
					end
				end
	    end
	  end
	end
end