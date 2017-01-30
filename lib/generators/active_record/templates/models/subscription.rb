class NotificationHub::Subscription < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_subscriptions"
  
  belongs_to :<%= user_model %>
  has_many :notification_hub_subscription_devices, class_name: 'NotificationHub::SubscriptionDevice', dependent: :destroy, foreign_key: 'notification_hub_subscription_id'
  has_many :notification_hub_devices, class_name: 'NotificationHub::Device', through: :notification_hub_subscription_devices

  validates :<%= user_model %>, :event_code, :channel_code, presence: true
  validates_inclusion_of :event_code, :in => ::NotificationHub.events.keys
  validates_inclusion_of :channel_code, :in => ["email", "webhook", "sms", "mobile_push_notification"]
	validates_inclusion_of :gateway_code, :in => ["action_mailer"], if: Proc.new { |s| s.gateway_code.present? && s.channel_code == "email" }
	validates_inclusion_of :gateway_code, :in => ["aws"], if: Proc.new { |s| s.gateway_code.present? && s.channel_code == "sms" }
	validates_inclusion_of :gateway_code, :in => ["fcm"], if: Proc.new { |s| s.gateway_code.present? && s.channel_code == "mobile_push_notification" }
	validates_inclusion_of :gateway_code, :in => ["httparty"], if: Proc.new { |s| s.gateway_code.present? && s.channel_code == "webhook" } 
end