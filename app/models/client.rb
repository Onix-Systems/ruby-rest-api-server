class Client < ActiveRecord::Base
  has_many :client_products, inverse_of: :client, dependent: :destroy
  has_many :products, through: :client_products

  accepts_nested_attributes_for :client_products

  validates :client_type, :gln, :full_name, :short_name, :description, presence: true

  validates :gln, :full_name, :short_name, uniqueness: true

  validates :client_type, :gln, numericality: { only_integer: true }

  validates :full_name, :short_name, length: { maximum: 140 }

  validates :description, length: { maximum: 500 }
end
