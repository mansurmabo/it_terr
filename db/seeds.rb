puts 'starting add data'

5.times do
  User.create(login: FFaker::Internet.email)
end

puts 'Users added'

20.times do
  User.all.each do |user|
    user.posts.create(
      title: FFaker::BaconIpsum.word,
      description: FFaker::BaconIpsum.sentence,
      ip_address: FFaker::Internet.ip_v4_address
    )
  end
end

puts 'Posts added'

100.times do
  Post.all.each do |post|
    post.ratings.create(mark: Random.new.rand(1..5))
  end
end

puts 'Ratings added'
