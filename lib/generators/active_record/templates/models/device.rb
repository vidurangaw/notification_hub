class NotificationHub::Device < <%= rails5? ? "ApplicationRecord" : "ActiveRecord::Base" %>	
  self.table_name = "notification_hub_devices"
  
  belongs_to :<%= user_model %>
  has_many :notification_hub_devices, class_name: 'NotificationHub::Device', dependent: :destroy

  validates_presence_of :<%= user_model %>
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/  
  validates_format_of :webook_url, format: URI::regexp(%w(http https))  
  validates_format_of :phone_number, with: /\A[^@\s]+@[^@\s]+\z/
end