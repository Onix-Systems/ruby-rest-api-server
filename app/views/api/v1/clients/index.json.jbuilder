json.array!(@clients) do |client|
  json.extract! client, :id, :client_type, :gln, :full_name, :short_name, :description, :created_at, :updated_at
  json.url api_v1_client_url(client, format: :json)
end
