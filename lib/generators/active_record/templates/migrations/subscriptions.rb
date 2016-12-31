class CreateNotificationHubSubscriptions < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :notification_hub_subscriptions do |t|
    	t.references :<%= user_model %>, null: false
      t.string :event_id, null: false, index: true
      t.string :channel_id, null: false, index: true
      t.string :gateway_id, index: true
      t.timestamps null: false
    end
  end
end
