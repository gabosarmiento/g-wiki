require 'faker'

rand(10..30).times do
  w = Wiki.create(title: Faker::Lorem.words(rand(1..10)).join(" "), description: Faker::Lorem.words(rand(4..15)).join(" "), body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
end 


puts "Seed finished"
puts "#{Wiki.count} wikis created"