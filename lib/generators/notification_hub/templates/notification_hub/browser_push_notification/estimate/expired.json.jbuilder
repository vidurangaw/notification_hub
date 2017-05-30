company = estimate.company
json.notification do
	json.title "#{I18n.t(:expired, scope: LocaleScope::SCOPE_NOTIFICATIONS_ESTIMATE)} – #{company.primary_business.name}"
	json.body "#{I18n.t(:estimate, scope: LocaleScope::SCOPE_NOTIFICATIONS_ESTIMATE)} #{estimate.statement_no} #{I18n.t(:sent_to, scope: LocaleScope::SCOPE_NOTIFICATIONS_ESTIMATE)} #{estimate.connection_name} #{I18n.t(:has_expired, scope: LocaleScope::SCOPE_NOTIFICATIONS_ESTIMATE)}"
	json.icon "https://s3.amazonaws.com/hiveage-production/defaults/business_logo.png"
	json.click_action Rails.application.routes.url_helpers.estimate_url(estimate, host: NotificationHubHelper.host_url(company), 
		protocol: NotificationHubHelper.account_schema(company))
end

