class NotificationHubJob
  include Sidekiq::Worker
  sidekiq_options :queue => :<%= queue_name %>, :retry => 10, :backtrace => true

  def perform(method, association_model_id, event_code, data, device_details=nil, 
  	channel_code=nil, gateway_code=nil)
    if method == "deliver"
    	NotificationHub.send_message(association_model_id, event_code, data)
    elsif method == "deliver_direct"
    	NotificationHub.send_direct_message(event_code, data, device_details, 
    		channel_code, gateway_code)
    end
  end
end
