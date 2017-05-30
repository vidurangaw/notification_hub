class CreateNotificationHubDevices < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :notification_hub_devices do |t|
    	t.references :<%= association_model %>, null: false
      t.string :channel_code, index: true
      t.string :email
      t.string :webhook_url
      t.string :phone_number
      t.string :push_token
      t.string :push_platform, index: true
      t.timestamps null: false 
    end
  end
end

