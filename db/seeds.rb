require 'faker'

u = User.new(
  username: ENV['ADMIN_NAME'].dup,
  email: ENV['ADMIN_EMAIL'].dup, 
  password: ENV['ADMIN_PASSWORD'].dup, 
  password_confirmation: ENV['ADMIN_PASSWORD'].dup)
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
  email: 'pro@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'pro')

u = User.new(
  username: 'Client free',
  email: 'free@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'free')

User.all.each do |u|
  puts "#{u.username}"
  rand(5..15).times do
    w = u.wikis.create(
      wikiname: Faker::Lorem.words(rand(1..10)).join(" "), 
      description: Faker::Lorem.words(rand(4..15)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    w.update_attribute(:created_at, Time.now - rand(600..31536000))
    puts "#{w.user_id}"
  end 
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"