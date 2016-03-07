class Client < ActiveRecord::Base
  validates :client_type, :gln, :full_name, :short_name, :description, presence: true

  validates :client_type, :gln, numericality: { only_integer: true }

  validates :full_name, :short_name, length: { minimum: 4, maximum: 140 }

  validates :description, length: { minimum: 5, maximum: 500 }

  validates :gln, :full_name, :short_name, uniqueness: true
end
