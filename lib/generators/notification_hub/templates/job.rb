class NotificationHubJob < ApplicationJob
  queue_as :<%= queue_name %>

  def perform(user_id, event_id, data, options)
    NotificationHub.send_message(user_id, event_id, data, options)
  end
end
