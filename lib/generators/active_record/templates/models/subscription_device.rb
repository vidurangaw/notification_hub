class NotificationHub::SubscriptionDevice < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_subscription_devices"

  belongs_to :notification_hub_subscription, :class_name => "NotificationHub::Subscription"
  belongs_to :notification_hub_device, :class_name => "NotificationHub::Device"

  validates :notification_hub_subscription, :notification_hub_device, presence: true
end