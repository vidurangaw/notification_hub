module NotificationHub
	module Workers	  
    class ActiveJob < Base
    	@@worker_code = :active_job
   	    	
      def initialize(configuration)	  
      	super
      end
   
      class << self      	
 				def worker_code
					@@worker_code
				end
			end
	  end

    class NotificationHubJob < ActiveJob::Base
      queue_as :default

      def perform(*args)
        Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
      end
    end
	end
end

