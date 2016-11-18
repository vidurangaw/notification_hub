require "notification_hub/version"
require 'http_logger'
require "httparty"

module NotificationHub  

	module Channels
		autoload 'Email', 'notification_hub/channels/email'
    autoload 'Base', 'notification_hub/channels/email/base'
    autoload 'ActionMailer', 'notification_hub/channels/email/action_mailer'
    autoload 'Mandrill', 'notification_hub/channels/email/mandrill'
  end

  class << self  
  	include HTTParty
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

    def send_now(event, data, options = nil)
    	send_message(event, data, options)
    end

    def send(event, data, options = nil)
    	NotificationHubJob.perform_later(event, data, options)
    end

    def send_message(event, data, options)
    	subscription = "Subscription"
    	#query subsccriptions and find susbcription for the relevant event
    	
      channels = [:email, :webhook]

      channels.each do |channel|
      	channel_const = "NotificationHub::Channels::#{channel.to_s.camelize}".constantize
      	options_ = channel_const.options
      	options_ = options_.merge(options) if options_.present? && options.present?
      	channel_const.send_message(event, data, options_)
      end      
    end

	end
end
