
Category.create!([{ name: 'Food' }, { name: 'Programming' },
                  { name: 'Sports' }, { name: 'Travel' },
                  { name: 'Exercise' }, { name: 'News' }, 
                  { name: 'Weather' }])

User.create! username: "mkweick",
             password: "hhockey18",
             password_confirmation: "hhockey18",
             email: "mkweick@gmail.com",
             time_zone: "Eastern Time (US & Canada)" 

5.times do |n|
  User.create! username: (Faker::Name.first_name.downcase + "_" + 
                          Faker::Name.last_name.downcase),
               password: "password",
               password_confirmation: "password",
               email: "example-#{n+1}@railstutorial.org",
               time_zone: "Eastern Time (US & Canada)"
end

75.times do
  Post.create! user_id: rand(1..6),
               title: (Faker::Lorem.characters(rand(3..10)).capitalize + ' ' + 
                       Faker::Lorem.characters(rand(3..9)).capitalize),
               url: Faker::Internet.url,
               description: Faker::Lorem.paragraph(8, false, 0)
end

75.times do
  PostCategory.create post_id: rand(1..65),
                      category_id: rand(1..7)
end

125.times do
  Comment.create! user_id: rand(1..6),
                  post_id: rand(1...65),
                  body: Faker::Lorem.paragraph(rand(1..4), false, 0)
end

150.times do
  type = rand(0..1)
  Vote.create user_id: rand(1..6),
              voteable_type: (type == 1 ? "Post" : "Comment"),
              voteable_id: (type == 1 ? rand(1..65) : rand(1..40))
end

puts'-'*100
puts "#{User.count} Users created"
puts "#{Category.count} Categories created"
puts "#{Post.count} Posts created"
puts "#{PostCategory.count} PostCategories created"
puts "#{Vote.count} Votes created"
puts'-'*100