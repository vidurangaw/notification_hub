require 'notification_hub/channels/browser_push_notification/fcm'

module NotificationHub
	module Channels
		module BrowserPushNotification		
	    class << self
				attr_accessor :default_gateway

				def send_message(event_code, data, options, gateway = nil)
					gateway ||= default_gateway			
					"NotificationHub::Channels::BrowserPushNotification::#{gateway.to_s.camelize}".constantize.send_message(event_code, data, options)
				end
			end
	  end
  end
end