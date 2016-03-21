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
User.delete_all


# 1 real user and 4 fake users
id = 1
User.create id: id, name: 'Huy', email: 'td.huycan@gmail.com', password: '1', password_confirmation: '1'
4.times do
  id += 1
  User.create id: id, name: Faker::StarWars.character, email: Faker::Internet.email, password: '1', password_confirmation: '1'
end

# 1st user is friends of all other 4 users
user_id = 1
id = 0
3.times do
  user_id += 1
  id += 1
  Friendship.create id: id, inviter_id: 1, accepter_id: user_id
end
Friendship.create id: 4, inviter_id: 5, accepter_id: 1

# 1st user sends and receives messages from 3 other users
id = 0
user_id = 1
3.times do
  user_id += 1
  id += 1
  Message.create id: id, sender_id: user_id, receiver_id: 1, content: Faker::Hipster.sentence
  id += 1
  Message.create id: id, sender_id: 1, receiver_id: user_id, content: Faker::Hipster.paragraph
end
Message.find(1).update read_at: Faker::Time.forward(2)
