json.extract! @client, :id, :client_type, :gln, :full_name, :short_name, :description, :created_at, :updated_at

if @client.products.any?
  json.products @client.products do |product|
    json.extract! product, :id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code,
                  :brand_name, :description_short, :description_full, :active, :created_at, :updated_at
    json.url api_v1_product_url(product, format: :json)
  end
end
