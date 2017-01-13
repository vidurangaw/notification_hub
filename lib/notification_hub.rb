require "notification_hub/version"
require "http_logger"
require "httparty"

module NotificationHub  
  mattr_accessor :user_class
  mattr_accessor :events
  mattr_accessor :logger     

  class << self    
		def setup
      @@user_class = "User"
      @@logger = Rails.logger

      raise ArgumentError, 'No block given for setup' unless block_given?
      yield self   
    end

    def set_channel(*args)
    	channel = args[0]    	
    	options = args[1]
      gateway = options[:gateway]
    	
      "NotificationHub::Channels::#{channel.to_s.camelize}::#{gateway.to_s.camelize}".constantize.new(options)
    end

    def send_now(user_id, event_id, data, options)
    	send_message(user_id, event_id, data, options)
    end

    def send(user_id, event_id, data, options)
    	NotificationHubJob.perform_later(user_id, event_id, data, options)
    end

    def send_message(user_id, event_id, data, options = nil)  
    	# Query subsccriptions for the relevant event    	
      susbcriptions = NotificationHub::Subscription.where("#{user_model}_id" => user_id)

      # Example device details
      # device_details = {
      #   email: "vpowerrc@gmail.com",
      #   webhook_url: "https://httpbin.org/post",
      #   phone_number: "+94716513320",
      #   push_token: "dfSfHOsxo08:APA91bG25YM94QkkTsnBihEAg0VlocA7KRQuWo4P6Hyxn-_rPB0lpWqLkf4AIbcIuPxeGMh_5tWCYGjdfV98raXE8_APWvmuPpk-8t5SUEoRXMuPpZVvpuxpdTkrY2LR31zQdBzKkZsO",
      #   push_platform: "android"
      # }

      susbcriptions.each do |susbcription|
        if susbcription.gateway_id.present?
          channel_const = "NotificationHub::Channels::#{susbcription.channel_id.camelize}::#{susbcription.gateway_id.camelize}".constantize
        else
          channel_const = "NotificationHub::Channels::#{susbcription.channel_id.camelize}".constantize
        end

        susbcription.notification_hub_devices.try(:each) do |device|
          device_details = device.attributes.symbolize_keys
          begin
            channel_const.send_message(event_id, data, device_details)
          rescue => e
            NotificationHub.logger.error e.message
          end          
        end
      end     
    end


    def user_model
      NotificationHub.user_class.downcase
    end 

	end
end
