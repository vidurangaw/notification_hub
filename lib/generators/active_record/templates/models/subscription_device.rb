class NotificationHub::SubscriptionDevice < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_subscription_devices"
  belongs_to :subscription
  belongs_to :device

  validates :subscription, :device, presence: true
end