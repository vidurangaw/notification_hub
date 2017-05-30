company = estimate.company
json.company_id company.id
json.company_subdomain company.subdomain
json.data do
  json.estimate API::EstimateSerializer.new(estimate)
end