NotificationHub.configure do |config|
  # ==> Email configuration
  config.set_channel :email, {
    gateway: :action_mailer
  } 
  
  # ==> Webhook configuration
  # FIXME
  # gateway(required): httparty is the default http client  
  # template_path(optional): default path is app/views/notification_hub/webhook
  config.set_channel :webhook, {   
    gateway: :httparty
    #timeout_time: 10
    #template_path: "notification_hub/webhook" 
  }

  # ==> SMS configuration
  # gateway(required): aws is the default sms client  
  # template_path(optional): default path is app/views/notification_hub/sms
  # *prerequisite: install and configure aws gem (https://github.com/aws/aws-sdk-ruby)
  config.set_channel :sms, {  
    gateway: :aws 
    #template_path: "notification_hub/sms" 
  }

  # ==> Mobile Push Notification configuration
  # gateway(required): FCM is the default push notification client    
  # server_key(required if using FCM)
  # notification parameters - https://firebase.google.com/docs/cloud-messaging/http-server-ref#notification-payload-support
  # template_path(optional): default path is app/views/notification_hub/mobile_push_notification
  config.set_channel :mobile_push_notification, {  
    gateway: :fcm,
    server_key: "test" 
    #template_path: "notification_hub/mobile_push_notification" 
  }

  # ==> Browser Push Notification configuration
  # gateway(required): FCM is the default push notification client    
  # web api_key(required if using FCM)
  # server_key(required if using FCM)
  # notification parameters - https://firebase.google.com/docs/cloud-messaging/http-server-ref#notification-payload-support
  # template_path(optional): default path is app/views/notification_hub/browser_push_notification
  config.set_channel :browser_push_notification, {  
    gateway: :fcm,
    web_api_key: "test",
    server_key: "test"  
    #template_path: "notification_hub/browser_push_notification" 
  }

  #Define the events here
  config.events = {  
    #"user.welcome" => "Welcome message"
  }

  config.association_model = "<%= association_model %>"
end