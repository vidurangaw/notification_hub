# NotificationHub

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/notification_hub`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notification_hub'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification_hub

## INTRODUCTION

This gem can be used to centralize the notification dispatching of an application.

Currently, this gem supports 5 notification channels.
* Email	
* Webhook
* SMS
* Mobile Push Notifications
* Browser Push Notifications

Each channel can be configured to use with a gateway. 
Below gateways are already bult-in. You can always add custom gateways.
* Email	- ActionMailer
* Webhook - HTTParty
* SMS - AWS
* Mobile Push Notifications - FCM(Firebase Cloud Messaging)
* Browser Push Notifications - FCM(Firebase Cloud Messaging)

## SETUP

Step 1
Generate relavant configuration and template files

rails generate notification_hub [Association Model] 
*Association Model: default value is "user"
*Currently, ActiveRecord ORM is only supported.

Step 2
Background processor intergration (Optional)

rails generate notification_hub:job [Background Processor] [Queue]
*Background Processor: options ["active_job", "sidekiq"]
*Queue: default value is "default"

Step 3
Run database migrations

rails db:migrate


## Usage

Step 1
Complete gateway settings in configuration file (config/initializers/notification_hub.rb)
Example: Push notifications
config.set_channel :mobile_push_notification, {  
  gateway: :fcm,
  server_key: "test"
}

Step 2
Define events in configuration file (config/initializers/notification_hub.rb)
Example:
config.events = {  
	[Event Code] => [Event Name],
  "user.signed_up" => "When an user is signed up",
  "user.trial_ended" => "When the trial period is ended",
  "message.received" => "When a message is received"
}

Event code is namespaced by ".". For example, you can use relevant model name
as the first part of the code and actual event name as the last part,

Step 2
Create message templates

Examples: URL

For emails you need to create mailers too.
Example: (app/mailers/user_mailer.rb)
class UserMailer < ActionMailer::Base
  def signed_up(data, to_email)
    mail(to: to_email, subject: "Welcome to XYZ")
  end

  def trial_ended(data, to_email)
    mail(to: to_email, subject: "[XYZ] Trial period ended")
  end
end

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/notification_hub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

