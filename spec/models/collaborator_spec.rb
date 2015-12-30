require 'rails_helper'
include RandomData

RSpec.describe Collaborator, type: :model do
    
   let(:wiki) { create(:wiki) }
   let(:user) { create(:user) }

   let(:collaborator) { Collaborator.create!(wiki: wiki, user: user) }
 
   it { should belong_to(:wiki) }
   it { should belong_to(:user) }
   
end
