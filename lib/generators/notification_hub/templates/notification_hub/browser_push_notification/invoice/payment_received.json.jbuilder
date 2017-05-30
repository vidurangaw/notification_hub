company = invoice.company
json.notification do
	json.title "#{I18n.t(:payment_received, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)} – #{company.primary_business.name}"
	json.body "#{I18n.t(:payment_of, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)} #{payment.currency} #{payment.amount.format_with_decimal(2)} (#{I18n.t(:via, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)} #{payment.payment_method_name}) #{I18n.t(:received_from, scope: LocaleScope::SCOPE_NOTIFICATIONS_INVOICE)} #{invoice.connection_name}"
	json.icon "https://s3.amazonaws.com/hiveage-production/defaults/business_logo.png"
	json.click_action Rails.application.routes.url_helpers.invoice_url(invoice, host: NotificationHubHelper.host_url(company), 
		protocol: NotificationHubHelper.account_schema(company))
end