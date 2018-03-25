FactoryBot.define do
  factory :user do
    login FFaker::Internet.user_name
  end
end
