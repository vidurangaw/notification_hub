module NotificationHub
	module Channels
	  module Email
	    class ActionMailer < Base
	      @@gateway_code = :action_mailer

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event, data, options)						
						event = event.split(".")
						"#{event[0].camelize}Mailer".constantize.send(event[1].to_sym, data).deliver
					end

					def gateway_code
						@@gateway_code
					end
				end
	    end
	  end
	end
end