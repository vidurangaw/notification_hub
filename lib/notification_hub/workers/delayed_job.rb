module NotificationHub
	module Workers	  
    class DelayedJob < Base
    	@@worker_code = :delayed_job
   	    	
      def initialize(configuration)	  
      	super
      end
   
      class << self      	
 				def worker_code
					@@worker_code
				end
			end
	  end
	end
end