module NotificationHub
	module DeviceManager
	  class << self

			def create_device(association_model_id, channel_code, device_details)
				NotificationHub::Device.where("#{NotificationHub.association_model}_id" => association_model_id, 
					channel_code: channel_code).where(device_details).first_or_create!
			end

			def update_device(id, device_details)				
				device = NotificationHub::Device.find(id).update_attributes(device_details)
			end

			def delete_device(id)
				NotificationHub::Device.find(id).destroy
			end
		end	  
  end
end