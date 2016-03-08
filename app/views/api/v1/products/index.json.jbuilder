json.array!(@products) do |product|
  json.extract! product, :id, :gtin, :information_provider_gln, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short, :description_full, :active
  json.url product_url(product, format: :json)
end
