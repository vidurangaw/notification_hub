module NotificationHub
	module Workers	  
    class RealTime < Base
    	@@worker_code = :real_time
   	    	
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