module NotificationHub
  module Generators
    class JobGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :background_processor, type: :string, default: "active_job"
      argument :queue_name, type: :string, default: "default"

      desc "copy job file to app/jobs directory"
      def copy_job_file
        if background_processor == "active_job"
          template "jobs/active_job.rb", "app/jobs/notification_hub_job.rb"
        elsif background_processor == "sidekiq"
          template "jobs/sidekiq_job.rb", "app/jobs/notification_hub_job.rb"
        end
      end
    end
  end
end