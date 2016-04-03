FactoryGirl.define do
  factory :client do
    client_type Random.rand(1..3)
    sequence(:gln) { |n| 1_000_000_000_000 + n }
    sequence(:full_name) { |n| "#{Faker::Company.suffix} #{Faker::Company.name} #{n}" }
    sequence(:short_name) { |n| "#{Faker::Company.name} #{n}" }
  end
end
