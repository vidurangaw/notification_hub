require 'notification_hub/channels/email/base'

module NotificationHub
	module Channels
	  module Email
	    class ActionMailer < Base
	      @gateway_code = :action_mailer

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(event_code, data, options)						
						event = event_code.split(".")

						begin
							if Rails.version.to_f >= 4.2
								"#{event[0].camelize}Mailer".constantize.send(event[1].to_sym, data, options[:email]).deliver_now
							else
								"#{event[0].camelize}Mailer".constantize.send(event[1].to_sym, data, options[:email]).deliver
							end
						rescue => exception
						  raise "Email::ActionMailer Error: #{exception.message}"
						end
					end
				end
	    end
	  end
	end
end