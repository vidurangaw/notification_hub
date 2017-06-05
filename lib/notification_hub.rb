require "notification_hub/version"
require "http_logger"
require "httparty"
require 'notification_hub/channels/email'
require 'notification_hub/channels/mobile_push_notification'
require 'notification_hub/channels/browser_push_notification'
require 'notification_hub/channels/sms'
require 'notification_hub/channels/webhook'
require 'notification_hub/subscription_manager'
require 'notification_hub/device_manager'

module NotificationHub  
  mattr_accessor :association_model
  mattr_accessor :events
  mattr_accessor :logger     

  class << self    
    def configure
      @@association_model ||= "user"
      @@logger = Logger.new("#{Rails.root}/log/notification_hub.log")
      yield self
    end

    def set_channel(*args)
    	channel = args[0]
    	options = args[1]
      gateway = options[:gateway]

      "NotificationHub::Channels::#{channel.to_s.camelize}::#{gateway.to_s.camelize}".constantize.new(options)
    end

    def deliver_now(association_model_id, event_code, data)
    	send_message(association_model_id, event_code, data)      
    end

    def deliver(association_model_id, event_code, data)   
      if NotificationHubJob.respond_to?("perform_later".to_sym)   
        NotificationHubJob.perform_later("deliver", association_model_id, event_code, data)      
      elsif NotificationHubJob.respond_to?("perform_async".to_sym)
        NotificationHubJob.perform_async("deliver", association_model_id, event_code, data)    
      end
    end

    def deliver_direct_now(event_code, data, device_details, channel_code, gateway_code=nil)
      send_direct_message(event_code, data, device_details, channel_code, gateway_code)     
    end

    def deliver_direct(event_code, data, device_details, channel_code, gateway_code=nil)   
      if NotificationHubJob.respond_to?("perform_later".to_sym)   
        NotificationHubJob.perform_later("deliver_direct", nil, event_code, data, device_details, channel_code, gateway_code)      
      elsif NotificationHubJob.respond_to?("perform_async".to_sym)
        NotificationHubJob.perform_async("deliver_direct", nil, event_code, data, device_details, channel_code, gateway_code)    
      end
    end

    def send_message(association_model_id, event_code, data_wrapper)  
      unless NotificationHub.events.keys.include? event_code
        NotificationHub.logger.error "Event code is not registered"
        NotificationHub.logger.error "Event:#{event_code}"
        raise "Event code is not registered"
      end

      # Fetch data from the database if record id is passed.
      data = {}
      data_wrapper.each do |key,value|
        if value.is_a?(Integer)
          data[key.to_sym] = key.to_s.classify.constantize.find_by_id(value)
        else
          data[key.to_sym] = value
        end
      end

    	# Query subsccriptions for the relevant event.    	
      susbcriptions = NotificationHub::Subscription.where("#{association_model}_id" => association_model_id, event_code: event_code)

      susbcriptions.each do |susbcription|
        if susbcription.gateway_code.present?
          channel_const = "NotificationHub::Channels::#{susbcription.channel_code.camelize}::#{susbcription.gateway_code.camelize}".constantize
        else
          channel_const = "NotificationHub::Channels::#{susbcription.channel_code.camelize}".constantize
        end

        susbcription.notification_hub_devices.try(:each) do |device|
          device_details = device.attributes.symbolize_keys
          begin
            channel_const.send_message(event_code, data, device_details)
          rescue => e
            NotificationHub.logger.error e.message
            NotificationHub.logger.error "Event:#{event_code}  Channel:#{susbcription.channel_code}  Subscription: #{susbcription.id}  Device:#{device.id}"
            e.backtrace.each { |line| NotificationHub.logger.error line }
          end          
        end
      end     
    end

    def send_direct_message(event_code, data_wrapper, device_details, channel_code, gateway_code=nil)   

      # Fetch data from the database if record id is passed.
      data = {}
      data_wrapper.each do |key,value|
        if value.is_a?(Integer)
          data[key.to_sym] = key.to_s.classify.constantize.find_by_id(value)
        else
          data[key.to_sym] = value
        end
      end

      if gateway_code.present?
        channel_const = "NotificationHub::Channels::#{channel_code.camelize}::#{gateway_code.camelize}".constantize
      else
        channel_const = "NotificationHub::Channels::#{channel_code.camelize}".constantize
      end
      begin
        channel_const.send_message(event_code, data, device_details)
      rescue => e
        NotificationHub.logger.error e.message
        NotificationHub.logger.error "Event:#{event_code}  Channel:#{channel_code}  Device:#{device_details.to_json}"
        e.backtrace.each { |line| NotificationHub.logger.error line }
      end     
    end
	end
end
