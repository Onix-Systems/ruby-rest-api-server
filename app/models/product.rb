class Product < ActiveRecord::Base
  validates :gtin, :information_provider_gln, :bar_code_type, :unit_descriptor,
            :internal_supplier_code, :brand_name, :description_short, :description_full, presence: true

  validates :gtin, :information_provider_gln, numericality: { only_integer: true }

  validates :description_short, length: { minimum: 4, maximum: 140 }

  validates :description_full, length: { minimum: 5, maximum: 500 }

  validates :gtin, uniqueness: true
end
