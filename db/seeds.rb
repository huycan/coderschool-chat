# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# delete in order, to satisfy foreign key
Message.delete_all
Friendship.delete_all
Block.delete_all
User.delete_all

# 1 real user and 4 fake users
User.create name: 'huy', email: 'td.huycan@gmail.com', password: '1', password_confirmation: '1'
4.times do
  User.create name: Faker::StarWars.character, email: Faker::Internet.email, password: '1', password_confirmation: '1'
end

# add friends
users = User.where.not(email: 'td.huycan@gmail.com')
huy = User.find_by_email('td.huycan@gmail.com')
users.take(3).each do |user|
  huy.add_friend! user
end
users[3].add_friend! huy

# send messages
users.each do |user|
  user.send_messages!([ Message.new(receiver_id: huy.id, content: Faker::Hipster.sentence) ])
  huy.send_messages!([ Message.new(receiver_id: user.id, content: Faker::Lorem.sentence) ])
end
msg = huy.received_messages.first
msg.read_at_utc Time.now.utc
msg.save

# block
huy.block_friend! users.last