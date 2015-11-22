# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([{ name: 'Food' }, { name: 'Programming' },
                              { name: 'Sports' }, { name: 'Travel' },
                              { name: 'Exercise' }, { name: 'News' }, 
                              { name: 'Weather' }])

user = User.create  username: "mkweick",
                    password: "hhockey18",
                    password_confirmation: "hhockey18",
                    email: "mkweick@gmail.com",
                    time_zone: "Eastern Time (US & Canada)" 

5.times do |n|
  User.create username: (Faker::Name.first_name.downcase + "_" + Faker::Name.last_name.downcase),
              password: "hhockey18",
              password_confirmation: "hhockey18",
              email: "example-#{n+1}@railstutorial.org",
              time_zone: "Eastern Time (US & Canada)"
end

75.times do
  Post.create user_id: rand(1..6),
              title: Faker::Lorem.words(2).map(&:capitalize).join(' '),
              url: Faker::Internet.url,
              description: Faker::Lorem.paragraph(8, false, 0)
end

75.times do
  PostCategory.create post_id: rand(1..65),
                      category_id: rand(1..7)
end

125.times do
  Comment.create user_id: rand(1..6),
                 post_id: rand(1...65),
                 body: Faker::Lorem.paragraph(rand(1..4), false, 0)
end

150.times do
  type = rand(0..1)
  Vote.create user_id: rand(1..6),
              voteable_type: (type == 1 ? "Post" : "Comment"),
              voteable_id: (type == 1 ? rand(1..65) : rand(1..40))
end