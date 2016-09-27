# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 # Create Wikis
 25.times do

  password = Faker::Internet.password
  user = User.new(
  :email => Faker::Internet.email,
  :password => password,
  :password_confirmation => password
  )
  user.skip_confirmation!
  user.save!

paragraphs = Faker::Hipster.paragraphs(rand(12..24))
title = Faker::Hipster.word

   Wiki.create!(

     title:  title.titlecase,
     body:   paragraphs.join("\r\n\r\n"),
     private: false,
     user: user
   )
user_id = User.pluck(:id).shuffle[0]
user = User.find(user_id)

wiki_id = Wiki.pluck(:id).shuffle[0]
wiki = Wiki.find(wiki_id)
wiki.update(private: true)

   Collaborator.create!(
    wiki: wiki,
    user: user
    )
 end

  user = User.new(
  :email => 'byron.weiss@gmail.com',
  :password => 'helloworld',
  :password_confirmation => 'helloworld'
  )
  user.skip_confirmation!
  user.save!

   user = User.new(
  :email => 'bweiss@oak-park.us',
  :password => 'helloworld',
  :password_confirmation => 'helloworld'
  )
  user.skip_confirmation!
  user.save!

 wikis = Wiki.all


 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"
 puts "#{Collaborator.count} collaborators created"
