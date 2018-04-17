APP_ADDRESS = "http://localhost:3000"

puts 'starting add data'

# may changed it to more
5.times do
  User.create(login: FFaker::Internet.email)
end

puts 'Users added'

# may changed it to more
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

# may changed it to more
100.times do
  Post.all.each do |post|
    post.ratings.create(mark: Random.new.rand(1..5))
  end
end
puts 'Ratings added'

20.times do
  HTTParty.post("#{APP_ADDRESS}/posts?login=#{FFaker::Internet.email}&title=#{FFaker::BaconIpsum.word}&description=#{FFaker::BaconIpsum.sentence}")
end
puts 'created users and posts by controller'

Post.all.each do |post|
  HTTParty.post("#{APP_ADDRESS}/posts/#{post.id}/estimate?mark=#{Random.new.rand(1..5)}")
end
puts 'ratings added by controller'
