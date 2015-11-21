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

user = User.create username: "mkweick",
                    password: "hhockey18",
                    password_confirmation: "hhockey18",
                    email: "mkweick@gmail.com",
                    time_zone: "Eastern Time (US & Canada)" 

100.times do
  Post.create(user_id: 1,
              title: Faker::Lorem.words(2).map(&:capitalize).join(' '),
              url: Faker::Internet.url,
              description: Faker::Lorem.paragraph(8, false, 0))
end