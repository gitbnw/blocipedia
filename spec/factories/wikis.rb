 include RandomData
 
 FactoryGirl.define do


   factory :wiki do
     title RandomData.random_sentence
     body RandomData.random_paragraph
     private false
   end
 end