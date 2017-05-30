company = estimate.company
json.notification do
	json.title "#{I18n.t(:viewed, scope: LocaleScope::SCOPE_NOTIFICATIONS_ESTIMATE)} – #{company.primary_business.name}"
	json.body "#{I18n.t(:estimate, scope: LocaleScope::SCOPE_NOTIFICATIONS_ESTIMATE)} #{estimate.statement_no} #{I18n.t(:viewed_by, scope: LocaleScope::SCOPE_NOTIFICATIONS_GENERIC)} #{estimate.connection_name}"
	json.icon "https://s3.amazonaws.com/hiveage-production/defaults/business_logo.png"
	json.click_action Rails.application.routes.url_helpers.estimate_url(estimate, host: NotificationHubHelper.host_url(company), 
		protocol: NotificationHubHelper.account_schema(company))
end