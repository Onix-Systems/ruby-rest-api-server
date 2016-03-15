class Product < ActiveRecord::Base
  has_many :client_products, inverse_of: :product, dependent: :destroy
  has_many :clients, through: :client_products

  accepts_nested_attributes_for :client_products

  validates :gtin, :bar_code_type, :unit_descriptor,
            :internal_supplier_code, :brand_name, :description_short, presence: true

  validates :gtin, numericality: { only_integer: true }

  validates :gtin, uniqueness: true

  validates :description_short, length: { maximum: 140 }

  validates :description_full, length: { maximum: 500 }
end
