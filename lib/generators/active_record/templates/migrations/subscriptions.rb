class CreateNotificationHubSubscriptions < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :notification_hub_subscriptions do |t|
    	t.references :<%= user_model %>, null: false
      t.string :event_code, null: false, index: true
      t.string :channel_code, null: false, index: true
      t.string :gateway_code, index: true
      t.timestamps null: false
    end
  end
end
