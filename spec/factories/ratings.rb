FactoryBot.define do
  factory :rating do
    mark Random.new.rand(1..5)
  end
end
