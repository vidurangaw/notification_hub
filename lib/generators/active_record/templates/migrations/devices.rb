class CreateNotificationHubDevices < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :notification_hub_devices do |t|
    	t.references :<%= user_model %>, null: false
      t.string :email, index: true
      t.string :webhook_url, index: true
      t.string :phone_number, index: true
      t.string :mobile_token, index: true
      t.string :mobile_platform
      t.timestamps null: false 
    end
  end
end

