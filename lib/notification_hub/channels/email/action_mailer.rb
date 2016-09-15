module NotificationHub
	module Channels
	  module Email
	    class ActionMailer < Base
	      @@gateway_code = :action_mailer

	      def initialize(configuration)
	      	super
	      end

	      class << self
					def send_message(topic, variables)
						puts "#{gateway_code} #{topic} success"
					end

					def gateway_code
						@@gateway_code
					end
				end

	      # def pling_message(message, device, configuration)
	      #   @message, @device, @configuration = message, device, configuration

	      #   mail(:to => device.identifier, :from => configuration[:from], :subject => message.subject) do |format|
	      #     format.text { render 'pling/mailer/pling_message' } if configuration[:text]
	      #     format.html { render 'pling/mailer/pling_message' } if configuration[:html]
	      #   end
	      # end
	    end
	  end
	end
end