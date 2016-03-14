class Product < ActiveRecord::Base
  validates :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code,
            :brand_name, :description_short, :description_full, presence: true

  validates :gtin, numericality: { only_integer: true }

  validates :gtin, uniqueness: true

  validates :description_short, length: { maximum: 140 }

  validates :description_full, length: { maximum: 500 }
end
