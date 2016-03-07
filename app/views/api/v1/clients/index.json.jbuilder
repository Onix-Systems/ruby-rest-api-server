json.array!(@clients) do |client|
  json.extract! client, :id, :client_type, :gln, :full_name, :short_name, :description
  json.url client_url(client, format: :json)
end