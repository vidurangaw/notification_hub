class NotificationHub::Device < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_devices"
  
  belongs_to :<%= association_model %>
  has_many :notification_hub_subscription_devices, class_name: 'NotificationHub::SubscriptionDevice', dependent: :destroy, foreign_key: 'notification_hub_device_id'
  has_many :notification_hub_subscriptions, class_name: 'NotificationHub::Subscription', through: :notification_hub_subscription_devices
  
  validates_presence_of :<%= association_model %>
  validates_inclusion_of :channel_code, :in => ["email", "webhook", "sms", "mobile_push_notification", "browser_push_notification"]
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, if: Proc.new { |d| d.channel_code == "email" }
  validates_format_of :webhook_url, with: URI::regexp(%w(http https)), if: Proc.new { |d| d.channel_code == "webhook"}
  validates_presence_of :phone_number, if: Proc.new { |d| d.channel_code == "sms" }
  validates_presence_of :push_token, if: Proc.new { |d| d.channel_code == "mobile_push_notification" || d.channel_code == "browser_push_notification" }
  validates_inclusion_of :push_platform, :in => ["android", "ios", "browser"], if: Proc.new { |d| d.channel_code == "mobile_push_notification" || d.channel_code == "browser_push_notification" }
end