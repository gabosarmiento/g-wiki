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
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"),
      tag_list: Faker::Lorem.words(rand(2..5)).join(",")
      )
    w.update_attribute(:created_at, Time.now - rand(600..31536000))
    w.update_attribute(:public, true)
  end 
end

#Test Users
u = User.new(
  username: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  username: 'Client basic',
  email: 'clientbasic@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'basic')

u = User.new(
  username: 'Client pro',
  email: 'clientpro@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'pro')

u = User.new(
  username: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'free')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"