class CreateNotificationHubSubscriptionDevices < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :notification_hub_subscription_devices do |t|
    	t.belongs_to :notification_hub_subscription, index: {:name => "index_nb_subscription_devices_on_nh_subscription_id"}
      t.belongs_to :notification_hub_device, index: {:name => "index_nb_subscription_devices_on_nh_device_id"}
      t.timestamps  
    end
  end
end

