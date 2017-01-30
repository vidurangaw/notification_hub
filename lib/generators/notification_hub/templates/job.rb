class NotificationHubJob < ApplicationJob
  queue_as :<%= queue_name %>

  def perform(user_id, event_code, data, options)
    NotificationHub.send_message(user_id, event_code, data, options)
  end
end
