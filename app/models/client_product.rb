class ClientProduct < ActiveRecord::Base
  belongs_to :client, inverse_of: :client_products
  belongs_to :product, inverse_of: :client_products

  accepts_nested_attributes_for :client, allow_destroy: true
  accepts_nested_attributes_for :product, allow_destroy: true
end
