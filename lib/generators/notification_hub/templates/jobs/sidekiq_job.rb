class NotificationHubJob
  include Sidekiq::Worker
  sidekiq_options :queue => :<%= queue_name %>, :retry => 10, :backtrace => true

  def perform(association_model_id, event_code, data, options)
    NotificationHub.send_message(association_model_id, event_code, data, options)
  end
end
