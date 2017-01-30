class NotificationHub::Device < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_devices"
  
  belongs_to :<%= user_model %>
  has_many :notification_hub_subscription_devices, class_name: 'NotificationHub::SubscriptionDevice', dependent: :destroy, foreign_key: 'notification_hub_device_id'
  has_many :notification_hub_subscriptions, class_name: 'NotificationHub::Subscription', through: :notification_hub_subscription_devices
  
  validates_presence_of :<%= user_model %>
  validates_inclusion_of :channel_code, :in => ["email", "webhook", "sms", "mobile_push_notification"]
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, if: Proc.new { |d| d.email.present? }
  validates_format_of :webhook_url, with: URI::regexp(%w(http https)), if: Proc.new { |d| d.webhook_url.present? }
  validates_format_of :phone_number, with: /\A[^@\s]+@[^@\s]+\z/, if: Proc.new { |d| d.phone_number.present? }
  validates_presence_of :push_token, if: Proc.new { |d| d.push_platform.present? }
  validates_inclusion_of :push_platform, :in => ["android", "ios", "web"], if: Proc.new { |d| d.push_token.present? }

  def channel_code
    case self[:channel_code]
    when 0 then "email"
    when 1 then "webhook"
    when 2 then "sms"
    when 3 then "mobile_push_notification"
    end
  end

  def channel_code=(value)
    self[:channel_code] = case value
    when "email"                     then 0
    when "webhook"                   then 1
    when "sms"                       then 2
    when "mobile_push_notification"  then 3
    end
  end
end