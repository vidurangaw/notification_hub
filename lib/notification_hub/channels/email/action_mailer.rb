module NotificationHub
	module Channels
	  module Email
	    class ActionMailer < Base
	      @gateway_code = :action_mailer

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event_id, data, options)						
						event = event_id.split(".")
						"#{event[0].camelize}Mailer".constantize.send(event[1].to_sym, data, options[:email]).deliver
					end
				end
	    end
	  end
	end
end