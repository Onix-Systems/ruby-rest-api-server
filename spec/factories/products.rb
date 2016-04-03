FactoryGirl.define do
  factory :product do
    sequence(:gtin) { |n| 1_000_000_000_000 + n }
    bar_code_type Faker::Lorem.characters(10)
    unit_descriptor Faker::Lorem.characters(10)
    internal_supplier_code Faker::Lorem.characters(10)
    brand_name Faker::Commerce.product_name
    description_short Faker::Lorem.sentence
  end
end
