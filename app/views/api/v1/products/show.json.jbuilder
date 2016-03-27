json.extract! @product, :id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short, :description_full, :active, :created_at, :updated_at

if @product.clients.any?
  json.clients @product.clients do |client|
    json.extract! client, :id, :client_type, :gln, :full_name, :short_name, :description, :created_at, :updated_at
    json.url api_v1_client_url(client, format: :json)
  end
end
