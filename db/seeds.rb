require 'faker'

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    username: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save

  rand(5..15).times do
    w = u.wikis.create(
      wikiname: Faker::Lorem.words(rand(1..10)).join(" "), 
      description: Faker::Lorem.words(rand(4..15)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    w.update_attribute(:created_at, Time.now - rand(600..31536000))
  end 
end

u = User.first
u.skip_reconfirmation!
u.update_attributes(email: 'admin@example.com', password: 'helloworld', password_confirmation: 'helloworld')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"