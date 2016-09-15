require "notification_hub/version"

module NotificationHub  

	module Channels
		autoload 'Email', 'notification_hub/channels/email'
    autoload 'Base', 'notification_hub/channels/email/base'
    autoload 'ActionMailer', 'notification_hub/channels/email/action_mailer'
    autoload 'Mandrill', 'notification_hub/channels/email/mandrill'
  end

  class << self  
		def test
			return "success"
		end

		def send
			puts "sent"
		end

		def configure
      raise ArgumentError, 'No block given for configure' unless block_given?
      yield self   
    end

    def set_channel(*args)
    	channel = args[0]
    	gateway = args[1]
    	options = args[2]
    	
      "NotificationHub::Channels::#{channel.to_s.camelize}::#{gateway.to_s.camelize}".constantize.new(options)
    end

    def send_message(user_id, topic, variables, gateway = nil)
    	subscription = "Subscription"
    	
    	channel = :email
      "NotificationHub::Channels::#{channel.to_s.camelize}".constantize.send_message(topic, variables, gateway)
    end

	end
end
