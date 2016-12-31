class NotificationHub::Subscription < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_subscriptions"
  
  belongs_to :<%= user_model %>
  has_many :notification_hub_devices, class_name: 'NotificationHub::Device', dependent: :destroy

  validates :<%= user_model %>, :event_id, :channel_id, presence: true
  validates_inclusion_of :channel_id, :in => ["email", "webhook", "sms", "push_notification"]
	validates_inclusion_of :gateway_id, :in => ["action_mailer"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "email" }
	validates_inclusion_of :gateway_id, :in => ["aws"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "sms" }
	validates_inclusion_of :gateway_id, :in => ["fcm"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "push_notification" }
	validates_inclusion_of :gateway_id, :in => ["httparty"], if: Proc.new { |s| s.gateway_id.present? && s.channel_id == "webhook" } 
end