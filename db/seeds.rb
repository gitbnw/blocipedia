# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 include Faker
 
 # Create Wikis
 50.times do
  
  password = Faker::Internet.password
  user = User.new(
  :email => Faker::Internet.email,
  :password => password,
  :password_confirmation => password
  )
  user.skip_confirmation!
  user.save!

paragraphs = Faker::Lorem.paragraphs
title = Faker::Lorem.word

   Wiki.create!(

     title:  title.titlecase,
     body:   paragraphs.join("\r\n\r\n"),
     private: false,
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
 
 wikis = Wiki.all

 
 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"