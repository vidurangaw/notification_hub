company = invoice.company
json.company_id company.id
json.company_subdomain company.subdomain
json.data do
  json.invoice API::InvoiceSerializer.new(invoice)
end