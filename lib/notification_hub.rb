require "notification_hub/version"
require "http_logger"
require "httparty"

module NotificationHub  

  # module Channels
  #   autoload 'Email', 'notification_hub/channels/email'
  #   autoload 'Base', 'notification_hub/channels/email/base'
  #   autoload 'ActionMailer', 'notification_hub/channels/email/action_mailer'
  #   autoload 'Mandrill', 'notification_hub/channels/email/mandrill'
  # end

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

    def send_now(topic, data, options = nil)
    	send_message(topic, data, options)
    end

    def send(topic, data, options = nil)
    	NotificationHubJob.perform_later(topic, data, options)
    end

    def send_message(topic, data, options)
    	subscription = "Subscription"
    	#query subsccriptions and find susbcription for the relevant topic
    	
      #channels = [:email, :webhook, :sms]
      channels = [:webhook]

      options = {
        url: "https://httpbin.org/post",
        phone_number: "+94716513320"
      }

      channels.each do |channel|
      	channel_const = "NotificationHub::Channels::#{channel.to_s.camelize}".constantize
      	options_ = channel_const.options
      	options_ = options_.merge(options) if options_.present? && options.present?
      	channel_const.send_message(topic, data, options_)
      end      
    end

	end
end
