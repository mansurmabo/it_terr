FactoryBot.define do
  factory :post do
    title FFaker::DizzleIpsum.words
    description FFaker::DizzleIpsum.sentences
    ip_address FFaker::Internet.ip_v4_address

  end
end
