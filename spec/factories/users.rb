FactoryGirl.define do
  factory :user do
		profile

    email    { Faker::Internet.email }
    password { '11111111' }
  end
end