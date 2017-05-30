class NotificationHubJob < ActiveJob::Base
  queue_as :<%= queue_name %>

  def perform(association_model_id, event_code, data, options)
    NotificationHub.send_message(association_model_id, event_code, data, options)
  end
end
