module NotificationHub
  module Generators
    class JobGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :queue_name, type: :string, default: "default"

      desc "copy job file to app/jobs directory"
      def copy_job_file
        template 'job.rb', "app/jobs/notification_hub_job.rb"
      end
    end
  end
end