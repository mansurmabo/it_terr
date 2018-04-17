FactoryBot.define do
  factory :post do
    title FFaker::BaconIpsum.word
    description FFaker::BaconIpsum.sentence
    ip_address FFaker::Internet.ip_v4_address

  end
end
