company = invoice.company
json.notification do
	json.title "#{I18n.t(:overdue, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)} – #{company.primary_business.name}"
	json.body "#{I18n.t(:invoice, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)} #{invoice.statement_no} #{I18n.t(:for, scope: LocaleScope::SCOPE_NOTIFICATIONS_GENERIC)} #{invoice.connection_name} #{I18n.t(:is_now_overdue, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)}"
	json.icon "https://s3.amazonaws.com/hiveage-production/defaults/business_logo.png"
	json.click_action Rails.application.routes.url_helpers.invoice_url(invoice, host: NotificationHubHelper.host_url(company), 
		protocol: NotificationHubHelper.account_schema(company))
end