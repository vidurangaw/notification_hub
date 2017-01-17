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
    #template_path: "notification_hub/webhook" 
  }

  # ==> SMS configuration
  # gateway(required): aws is the default sms client  
  # template_path(optional): default path is app/views/notification_hub/sms
  config.set_channel :sms, {  
    gateway: :aws 
    #template_path: "notification_hub/sms" 
  }

  # ==> Push Notification configuration
  # gateway(required): FCM is the default push notification client    
  # api_key(required if using FCM): FCM api key
  # FCM parameters - https://firebase.google.com/docs/cloud-messaging/http-server-ref#notification-payload-support
  # template_path(optional): default path is app/views/notification_hub/mobile_push_notification
  config.set_channel :mobile_push_notification, {  
    gateway: :fcm,
    api_key: "test"  
    #template_path: "notification_hub/mobile_push_notification" 
  }

  #Define the events here
  config.events = {  
    #"user.welcome" => "Welcome message"
  }

  #default value is User
  #config.user_class = "User"
end