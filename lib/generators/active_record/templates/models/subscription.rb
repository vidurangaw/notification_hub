class NotificationHub::Subscription < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_subscriptions"
  
  belongs_to :<%= user_model %>
  has_many :notification_hub_subscription_devices, class_name: 'NotificationHub::SubscriptionDevice', dependent: :destroy, foreign_key: 'notification_hub_subscription_id'
  has_many :notification_hub_devices, class_name: 'NotificationHub::Device', through: :notification_hub_subscription_devices

  validates :<%= user_model %>, :event_id, :channel_id, presence: true
  validates_inclusion_of :event_id, :in => ::NotificationHub.events.keys
  validates_inclusion_of :channel_id, :in => ["email", "webhook", "sms", "push_notification"]
	validates_inclusion_of :gateway_id, :in => ["action_mailer"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "email" }
	validates_inclusion_of :gateway_id, :in => ["aws"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "sms" }
	validates_inclusion_of :gateway_id, :in => ["fcm"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "push_notification" }
	validates_inclusion_of :gateway_id, :in => ["httparty"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "webhook" } 
end