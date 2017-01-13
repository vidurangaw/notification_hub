module NotificationHub
	module DeviceManager
	  class << self

			def create_device(user_id, device_details)
				NotificationHub::Device.where("#{NotificationHub.user_model}_id" => user_id).where(device_details).first_or_create!
			end

			def update_device(id, device_details)				
				device = NotificationHub::Device.find(id)
				device.update!(device_details)
			end

			def delete_device(id)
				NotificationHub::Device.find(id).destroy!
			end
		end	  
  end
end