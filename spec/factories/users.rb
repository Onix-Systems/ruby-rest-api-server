FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.user_name }
    password { Faker::Internet.password }
    confirmed_at Time.zone.today
  end
end
