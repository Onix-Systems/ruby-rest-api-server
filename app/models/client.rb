class Client < ActiveRecord::Base
  has_and_belongs_to_many :products

  validates :client_type, :gln, :full_name, :short_name, :description, presence: true

  validates :gln, :full_name, :short_name, uniqueness: true

  validates :client_type, :gln, numericality: { only_integer: true }

  validates :full_name, :short_name, length: { maximum: 140 }

  validates :description, length: { maximum: 500 }
end
